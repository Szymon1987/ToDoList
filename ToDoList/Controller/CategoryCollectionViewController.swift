//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 20/01/2022.
//

import UIKit
import CoreData

class CategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories = [Category]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CATEGORIES"
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CellId")
        setUpNavigationController()
        
        loadCategory()

        
    }

    // MARK: - Table view data source

    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as? CustomCell else {
            fatalError("Unabele to dequeue the cell")
        }
            cell.titleLabel.text = categories[indexPath.row].name
            return cell
        
    }

    
    
   
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        let vc = ToDoListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.title = category.name
        vc.selectedCategory = category
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
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
        saveData()
    }
    
    func saveData() {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
            collectionView.reloadData()
        }

    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
           categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        collectionView.reloadData()
    }
    
    
    
        func updateModel(indexPath: IndexPath) {
        
        context.delete(categories[indexPath.row])
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        categories.remove(at: indexPath.row)
        
    }
    
    
}
