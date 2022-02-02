//
//  MainViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 31/01/2022.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func loadView() {
        super.loadView()
        setupViews()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = ColorManager.background
//                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

//                navigationController?.navigationBar.tintColor = .white
//                navigationController?.navigationBar.standardAppearance = appearance
//                navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

    }
   
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, handler in

            self.updateModel(at: indexPath)

            
        }
        let rename = UIContextualAction(style: .normal, title: "Rename") { action, view, handler in
            print("normal")
            
        }
        rename.backgroundColor = ColorManager.roundedButton
//        rename.image = UIImage(systemName: "circle.fill")
        return UISwipeActionsConfiguration(actions: [delete, rename])
    }

    
    func saveData() {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
            tableView.reloadData()
        }
    
    func updateModel(at indexPath: IndexPath) {
    }
    func setupViews() {
    }
    
}
