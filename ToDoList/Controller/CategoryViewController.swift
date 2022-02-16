//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 20/01/2022.
//

import UIKit
import CoreData

class CategoryViewController: MainViewController {

    // MARK: - Properties
    
    var categories = [Category]()

    
 // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CellId")
        loadCategory()
        navigationItem.title = "CATEGORIES"
        tableView.sectionHeaderTopPadding = 10
        tableView.separatorStyle = .none
    }
   
    // MARK: - TableView data source
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    // Two methods belew help with the spacing between the cells
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? CategoryCell else {
            fatalError("Unable to dequeue the CustomCell")
        }
        cell.baseCellDelegate = self
        let quantity = categories[indexPath.section].quantity
        let quantityDone = categories[indexPath.section].quantityDone
        cell.textField.text = categories[indexPath.section].name
        cell.quantityLabel.text = "\(quantityDone) / \(quantity)"
        let progress = Float(quantityDone) / Float(quantity)
        if quantityDone == 0 && quantity == 0 {
            cell.progressView.progress = 0
        } else {
            cell.progressView.progress = progress
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.section]
        let vc = ToDoListViewController()
        vc.title = category.name
        vc.selectedCategory = category
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - Helpers
    
    @objc override func addTapped() {
        let ac = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        
        ac.addAction(UIAlertAction(title: "Add ", style: .default, handler: { [weak self, weak ac] _ in
        guard let newCategory = ac?.textFields?[0].text else { return }
        self?.addCategory(newCategory)
        }))
    }

    func addCategory(_ category: String) {
        if category == "" { return }
        let newCategory = Category(context: context)
        newCategory.name = category
        
        if categories.contains(where: {$0.name == category}) {
            let ac = UIAlertController(title: "The category already exists", message: "Please insert unique catefory name", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
//            return
        } else {
            categories.append(newCategory)
            saveData()
            tableView.reloadData()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        tableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: -8))
    }
    
    // MARK: - CoreData
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
           categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    override func remove(at indexPath: IndexPath) {
        super.remove(at: indexPath)
        self.context.delete(self.categories[indexPath.section])
        self.categories.remove(at: indexPath.section)
        tableView.reloadData()
        self.saveData()
    }
    
}

    // MARK: - BaseCellDelegate

extension CategoryViewController {
    override func updateUI(sender: BaseCell, title: String) {
        if let selectedIndexPath = tableView.indexPath(for: sender) {
            categories[selectedIndexPath.section].name = title
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
        super.updateUI(sender: sender, title: title)
    }
}
    

        






