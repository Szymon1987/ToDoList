//
//  ViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 16/12/2021.
//
import CoreData
import UIKit

class ToDoListViewController: MainViewController, ItemCellProtocol {
        
    var items = [Item]()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    override func updateTitle(sender: BaseCell, title: String) {
        if let selectedIndexPath = tableView.indexPath(for: sender) {
            items[selectedIndexPath.row].title = title
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
        super.updateTitle(sender: sender, title: title)
    }
  
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
            showBinIcon()
            saveData()
        }
    }
    

    func showBinIcon() {
        // checks, if all items in the array have been selected
        if items.allSatisfy({ $0.done == true }) {
            let image = UIImage(named: "bin")?.withRenderingMode(.alwaysOriginal)
            let binButton = UIBarButtonItem(image: image, landscapeImagePhone: image, style: .plain, target: self, action: #selector(binPressed))
//            navigationItem.rightBarButtonItems?.append(binButton)
            navigationItem.setRightBarButton(binButton, animated: true)
        }
    }
    
    @objc func binPressed() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ItemCell.self, forCellReuseIdentifier: "CellId")
    }

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
                cell.textField.textColor = .black.withAlphaComponent(0.5)
            } else {
                cell.textField.textColor = .black.withAlphaComponent(1)
        }
            return cell
    }

    @objc override func addTapped() {
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "Add Item", style: .default) { [weak self, weak alert] _ in
            guard let item = alert?.textFields?[0].text else { return }
            self?.addItem(item)
        })
    }

    func addItem(_ item: String) {
        if item == "" { return }
        let newItem = Item(context: context)
        newItem.title = item
        newItem.done = false
        selectedCategory?.quantity += 1
        newItem.parentCategory = self.selectedCategory
        items.append(newItem)
        tableView.reloadData()
        saveData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        guard let selectedCategory = selectedCategory else { return }

        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory.name!)
        request.predicate = predicate
        do {
            items = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error) ")
        }
        tableView.reloadData()
    }
    
    override func setupViews() {

        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(roundedButton)
        roundedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        roundedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        roundedButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        roundedButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    override func remove(at indexPath: IndexPath) {
        self.context.delete(self.items[indexPath.row])
        if items[indexPath.row].done {
            selectedCategory?.quantityDone -= 1
        }
        self.items.remove(at: indexPath.row)
        self.selectedCategory?.quantity -= 1
        tableView.reloadData()
        self.saveData()
    }
}
