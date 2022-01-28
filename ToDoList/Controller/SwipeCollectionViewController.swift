//
//  SwipeTableViewController.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 26/01/2022.
//

import UIKit
import SwipeCellKit

class SwipeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SwipeCollectionViewCellDelegate {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
 
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as? CustomCell else {fatalError("Unable to dequeue the CustomCell")}
        cell.delegate = self
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
        self.updateModel(indexPath: indexPath)
        }

        deleteAction.image = UIImage(systemName: "trash.fill")

        return [deleteAction]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
 
        return options
    }
    
    
    func updateModel(indexPath: IndexPath) {
        
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        collectionView.reloadData()
    }
    
}
