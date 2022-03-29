//
//  ViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 16/12/2021.
//
import UIKit
import CoreData

class ToDoListViewController: MainViewController {
    
    // MARK: - Properties
    
    var items = [Item]()
    var selectedCategory: Category? {
        didSet {
//            loadItems()
            updateDataSource()
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ItemCell.self, forCellReuseIdentifier: "CellId")
        shouldShowBinButton()
    }
    
    
    // MARK: - TableView Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? ItemCell else { fatalError("Unable to dequeue ItemCell")}
        cell.baseCellDelegate = self
        cell.itemCellDelegate = self
        cell.textField.text = items[indexPath.row].title
        cell.checkmarkButton.isSelected = items[indexPath.row].done
        if items[indexPath.row].done {
            cell.textField.textColor = .label.withAlphaComponent(0.5)
        } else {
            cell.textField.textColor = .label.withAlphaComponent(1)
        }
        return cell
    }
    
    // MARK: - Helpers
    
    @objc override func sortButtonTapped() {
        if items.count > 1 {
            items.sort{$0.title! < $1.title!}
            tableView.reloadData()
        }
    }
    
    func shouldShowBinButton() {
        if items.isEmpty { return }
        // checks, if all items in the array have been selected
        if items.allSatisfy({ $0.done == true }) {
            let image = UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate)
            let binButton = UIBarButtonItem(image: image, landscapeImagePhone: image, style: .plain, target: self, action: #selector(binTapped))
            navigationItem.rightBarButtonItems = [binButton]
        } else {
            navigationItem.rightBarButtonItems = []
        }
    }
    
    @objc func binTapped() {
        let alert = UIAlertController(title: "Are you sure you want to remove all items?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
        // probaly [weak self, weak alert isnt't needed as we aren't passing any parameters in removeAllItems]
        alert.addAction(UIAlertAction(title: "Delete all", style: .default) { _ in
            self.removeAllItems()
            self.navigationItem.setRightBarButton(nil, animated: true)
        })
    }
    
    @objc override func addButtonTapped() {
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add Item", style: .default) { [weak self, weak alert] _ in
            guard let item = alert?.textFields?[0].text else { return }
            let trimmedItem = item.trimmingCharacters(in: .whitespacesAndNewlines)
            self?.addItem(trimmedItem)
        })
        present(alert, animated: true)
    }
    
    override func setupViews() {
        super.setupViews()
        tableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    // MARK: - CoreData
    
    func addItem(_ item: String) {
        if item == "" { return }
        let newItem = model.addObject(entityType: Item.self)
        newItem.title = item
        newItem.done = false
        selectedCategory?.quantity += 1
        newItem.parentCategory = self.selectedCategory
        items.append(newItem)
        tableView.reloadData()
        model.saveObject()
    }
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
//        guard let selectedCategory = selectedCategory else { return }
//
//        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory.name!)
//        request.predicate = predicate
//        do {
//            items = try model.context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error) ")
//        }
//        tableView.reloadData()
//    }
    
    func updateDataSource() {
        /// is it ok to force unwrap below?
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        self.model.fetchObjects(entityName: Item.self, predicate: predicate) { (fetchResult) in
            switch fetchResult {
            case .success(let items):
                self.items = items
            case .failure(_):
                self.items.removeAll()
            }
            self.tableView.reloadData()
        }
    }
    
    override func remove(at indexPath: IndexPath) {
        super.remove(at: indexPath)
//        model.context.delete(self.items[indexPath.row])
        let item = items[indexPath.row]
        model.deleteObject(item)
        if item.done {
            selectedCategory?.quantityDone -= 1
        }
        self.items.remove(at: indexPath.row)
        self.selectedCategory?.quantity -= 1
        tableView.reloadData()
        model.saveObject()
    }
    
    private func removeAllItems() {
        guard let selectedCategory = selectedCategory else { return }
        model.context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory.name!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchRequest.predicate = predicate
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try model.context.execute(batchDeleteRequest)
        } catch {
            print("Error removing all Items \(error)")
        }
        items.removeAll()
        selectedCategory.quantity = 0
        selectedCategory.quantityDone = 0
        tableView.reloadData()
        model.saveObject()
    }
}
// MARK: - ItemCellProtocol

extension ToDoListViewController: ItemCellProtocol {
    func toggleDone(sender: ItemCell) {
        if let selectedIndexPath = tableView.indexPath(for: sender) {
            items[selectedIndexPath.row].done.toggle()
            if items[selectedIndexPath.row].done == true {
                selectedCategory?.quantityDone += 1
            } else {
                selectedCategory?.quantityDone -= 1
            }
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            //            tableView.reloadData()
            shouldShowBinButton()
            model.saveObject()
        }
    }
}

// MARK: - BaseCellProtocol

extension ToDoListViewController: BaseCellProtocol {
    func updateUI(sender: BaseCell, title: String) {
        if let selectedIndexPath = selectedIndexPath {
            items[selectedIndexPath.row].title = title
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
        navigationItem.rightBarButtonItems = []
        model.saveObject()
        shouldShowBinButton()
    }
}
