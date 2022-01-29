//
//  ViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 16/12/2021.
//
import CoreData
import UIKit

class ToDoListViewController: UICollectionViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items = [Item]()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
//        cell.textLabel?.text = items[indexPath.row].title

        return cell
    }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

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
    
    func saveData() {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
            collectionView.reloadData()
        }
        
    

    func addItem(_ item: String) {
        if item == "" { return }
        let newItem = Item(context: context)
        newItem.title = item
        newItem.done = false
        newItem.parentCategory = self.selectedCategory
        items.append(newItem)
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
        collectionView.reloadData()
    }

        func updateModel(indexPath: IndexPath) {
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



