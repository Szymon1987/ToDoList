//
//  ViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 16/12/2021.
//

import UIKit

class ToDoListViewController: UITableViewController {

//    var shareView = SharePromptView()
    let itemArray = ["luna", "rysiek", "kupa"]
    
    override func loadView() {
        super.loadView()
//        view = shareView
        setUpNavigationController()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @objc func addTapped() {
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("alert is working fine")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


