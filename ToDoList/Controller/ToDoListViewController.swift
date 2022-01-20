//
//  ViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 16/12/2021.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var handler: Handler!
    
    override func loadView() {
        super.loadView()
        handler = Handler()
        setUpNavigationController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = handler
        tableView.delegate = handler
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    private func setUpNavigationController() {
//        navigationController?.navigationBar.backgroundColor = .blue
        navigationItem.title = "TODOLIST"
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
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}


