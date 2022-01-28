//
//  ViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 16/12/2021.
//
import CoreData
import UIKit

class ToDoListViewController: SwipeTableViewController {
    
    var items = [Item]()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

//        tableView.deselectRow(at: indexPath, animated: true)
        
        

    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setUpNavigationController()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
//
//
//        navigationController?.navigationBar.backgroundColor = .lightGray
//
//        navigationController?.tabBarController?.tabBar.backgroundColor = .lightGray
//        navigationController?.tabBarItem.title = "Luna"
//
//        let appearance = UINavigationBarAppearance()
//                appearance.backgroundColor = .lightGray
//                navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        loadItems()

    }
    
    private func setUpNavigationController() {
//        navigationController?.navigationBar.backgroundColor = .blue
        navigationItem.title = "MY LIST"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
    

        //this changes the titleColor, maybe there is better solution to this problem?
//        if #available(iOS 13.0, *) {
//            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        } else {
//            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        }
        
        
       
    }
  
    @objc func addTapped() {
        
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
        newItem.parentCategory = self.selectedCategory
        items.append(newItem)
        saveItems()
    }
    
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
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
    
    override func updateModel(indexPath: IndexPath) {
        items[indexPath.row].done = !items[indexPath.row].done
        context.delete(items[indexPath.row])
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        items.remove(at: indexPath.row)

    }
}



