//
//  ViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 16/12/2021.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var itemArray = ["luna", "rysiek", "kupa"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let categoryItem = itemArray[indexPath.row]
    
        let vc = CategoryTableViewController()
        vc.title = categoryItem
        navigationController?.pushViewController(vc, animated: true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpNavigationController()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
   
       
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        
        
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
            guard let category = alert?.textFields?[0].text else { return }
            self?.addCategory(category)
        })
        
    }
    
    func addCategory(_ category: String) {
        itemArray.insert(category, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}


