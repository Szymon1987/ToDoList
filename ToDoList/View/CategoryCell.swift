//
//  CustomCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 28/01/2022.
//

import UIKit

//protocol CategoryCellProtocol: AnyObject {
//    func updateCategoryTitle(sender: CategoryCell, title: String)
//}

class CategoryCell: BaseCell {
    
    var left: NSLayoutConstraint?
    var right: NSLayoutConstraint?
    var categoryTitle: String?

  
//    let cellBackgroundView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.3
        view.layer.borderColor = ColorManager.cellBorder
        return view
    }()
    
//    lazy var textField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = .red
//        textField.delegate = self
//        return textField
//    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        return label
    }()
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing == true {
            
        }
    }
    override func setupViews() {
        
//        addSubview(cellBackgroundView)
//        cellBackgroundView.anchorSize(to: self)

        addSubview(cellView)
        
        cellView.anchorSize(to: self)
        
        cellView.addSubview(textField)
        
        left = textField.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10)
        left?.isActive = true
        textField.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: cellView.centerXAnchor, constant: 30).isActive = true

        cellView.addSubview(quantityLabel)

        quantityLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        right = quantityLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10)
        right?.isActive = true
    }
}


//extension CategoryCell: UITextFieldDelegate {
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
////        if let categoryTitle = categoryTitle {
////            cellDelegate?.updateCategoryTitle(sender: self, title: categoryTitle)
////            print("called")
////
////        }
//          
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        let text = textField.text
//        if let unwrappedTrimmedText = text?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            if unwrappedTrimmedText == "" {
//                return false
//            } else {
//                categoryTitle = unwrappedTrimmedText
//                return textField.endEditing(true)
//            }
//        }
//        return true
//
//    }
//    
//}
  
