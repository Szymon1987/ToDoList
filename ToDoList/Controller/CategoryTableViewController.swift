//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 20/01/2022.
//

import UIKit
import CoreData
import SwipeCellKit

class CategoryTableViewController: UITableViewController {

    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CATEGORIES"
        setUpNavigationController()
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "CellId")
        loadCategory()
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        

//        context.delete(categories[indexPath.row])
//        categories.remove(at: indexPath.row)
//        saveCategory()


        let category = categories[indexPath.row]
        let vc = ToDoListViewController()
        vc.title = category.name
        vc.selectedCategory = category
        navigationController?.pushViewController(vc, animated: true)

    }
        
    private func setUpNavigationController() {
//        navigationController?.navigationBar.backgroundColor = .blue
        navigationItem.title = "CATEGORIES"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
    

        //this changes the titleColor, maybe there is better solution to this problem?
//        if #available(iOS 13.0, *) {
//            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        } else {
//            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        }
        
//        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
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
        saveCategory()
        print(category)
    }
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
           categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    
}
