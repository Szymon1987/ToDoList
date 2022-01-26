//
//  SwipeTableViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 26/01/2022.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
   
//    let cell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "CellId")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
            
//            context.delete(categories[indexPath.row])
//            self.saveCategory()
//            self.categories.remove(at: indexPath.row)
            
//            self.tableView.reloadData()
            
        }

        // customize the action appearance

        deleteAction.image = UIImage(systemName: "trash.fill")
        

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
        return options
    }
    
    
    
}
