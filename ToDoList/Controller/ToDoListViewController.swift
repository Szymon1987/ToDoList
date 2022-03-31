//
//  ViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 16/12/2021.
//
import UIKit

class ToDoListViewController: MainViewController {
    
    // MARK: - Properties
    
    var items = [Item]()
    var selectedCategory: Category? {
        didSet {
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
    
    // MARK: - UIInteraction
    
    @objc override func sortButtonTapped() {
        if items.count > 1 {
            items.sort{$0.title! < $1.title!}
            tableView.reloadData()
        }
    }

    @objc func binButtonTapped() {
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
    //MARK: - ViewSetup
    
    override func setupViews() {
        super.setupViews()
//        tableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        tableView.anchorSize(to: view)
    }
    
    
    func shouldShowBinButton() {
        if items.isEmpty { return }
        // checks, if all items in the array have been selected
        if items.allSatisfy({ $0.done == true }) {
            let image = UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate)
            let binButton = UIBarButtonItem(image: image, landscapeImagePhone: image, style: .plain, target: self, action: #selector(binButtonTapped))
            navigationItem.rightBarButtonItems = [binButton]
        } else {
            navigationItem.rightBarButtonItems = []
        }
    }
    
    
    // MARK: - CoreData
    
    func addItem(_ item: String) {
        if item == "" { return }
        let newItem = coreDataStack.addObject(entityType: Item.self)
        
        ///new method, probably better so implement later
//        let newItem = coreDataStack.create(type: Item.self)
        newItem.title = item
        newItem.done = false
        selectedCategory?.quantity += 1
        newItem.parentCategory = self.selectedCategory
        items.append(newItem)
        tableView.reloadData()
        coreDataStack.saveObject()
    }
    
    func updateDataSource() {
        /// is it ok to force unwrap below?
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        self.coreDataStack.fetchObjects(entityName: Item.self, predicate: predicate) { (fetchResult) in
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
        let item = items[indexPath.row]
        coreDataStack.deleteObject(item)
        if item.done {
            selectedCategory?.quantityDone -= 1
        }
        self.items.remove(at: indexPath.row)
        self.selectedCategory?.quantity -= 1
        tableView.reloadData()
        coreDataStack.saveObject()
    }
    
    private func removeAllItems() {
        guard let selectedCategory = selectedCategory else { return }
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory.name!)
        coreDataStack.deleteAllObjects(entityName: Item.self, predicate: predicate)
        items.removeAll()
        selectedCategory.quantity = 0
        selectedCategory.quantityDone = 0
        tableView.reloadData()
        coreDataStack.saveObject()
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
            shouldShowBinButton()
            coreDataStack.saveObject()
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
        coreDataStack.saveObject()
        shouldShowBinButton()
    }
}
