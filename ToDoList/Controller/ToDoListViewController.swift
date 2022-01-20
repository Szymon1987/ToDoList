//
//  ViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 16/12/2021.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    let itemArray = ["luna", "rysiek", "kupa"]
    
    
   
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
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Alert is working fine")
        }
//        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>))
//        alert.addAction(action)
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CategoryTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


