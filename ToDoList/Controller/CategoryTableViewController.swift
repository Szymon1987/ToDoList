//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 20/01/2022.
//

import UIKit
import CoreData

class CategoryTableViewController: SwipeTableViewController {

    var categories = [Category]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CATEGORIES"
        setUpNavigationController()
        
        loadCategory()
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let category = categories[indexPath.row]
        let vc = ToDoListViewController()
        vc.title = category.name
        vc.selectedCategory = category
        navigationController?.pushViewController(vc, animated: true)

    }
    

    private func setUpNavigationController() {

        navigationItem.title = "CATEGORIES"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        navigationController?.navigationBar.backgroundColor = .lightGray
        navigationController?.tabBarController?.tabBar.backgroundColor = .lightGray
        navigationController?.tabBarItem.title = "Luna"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .lightGray
//                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

//                navigationController?.navigationBar.tintColor = .white
//                navigationController?.navigationBar.standardAppearance = appearance
//                navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func addTapped() {
        let ac = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac .addAction(UIAlertAction(title: "Cancel", style: .cancel))
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
        categories.append(newCategory)
        super.saveData()
    }

    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
           categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    override func updateModel(indexPath: IndexPath) {
        
        context.delete(categories[indexPath.row])
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        categories.remove(at: indexPath.row)
        
    }
    
    
}
