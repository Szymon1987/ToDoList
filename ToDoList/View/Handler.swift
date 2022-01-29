//
//  SharePromptView.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 17/12/2021.
//
//
//import UIKit
//
//class Handler: NSObject, UITableViewDataSource, UITableViewDelegate {
//
//    let itemArray = ["luna", "rysiek", "kupa"]
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        itemArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
//        cell.textLabel?.text = itemArray[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cv = CategoryTableViewController()
//
//    }
//
//}
