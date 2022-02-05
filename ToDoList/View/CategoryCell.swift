//
//  CustomCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 28/01/2022.
//

import UIKit


class CategoryCell: UITableViewCell, UITextFieldDelegate {
    
//    var oldLeftAnchor: NSLayoutConstraint?
//    var newLeftAnchor: NSLayoutConstraint?
//    var oldTrailingAnchor: NSLayoutConstraint?
//    var newTrailingAnchor: NSLayoutConstraint?
//    let move = 50
    
    var left: NSLayoutConstraint?
    var right: NSLayoutConstraint?
    
    
    lazy var middle = frame.size.width / 2
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
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
    
        lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.backgroundColor = .red
        textField.delegate = self
        return textField
    }()
    
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
    private func setupViews() {
        
//        addSubview(cellBackgroundView)
//        cellBackgroundView.anchorSize(to: self)

        addSubview(cellView)
        
        cellView.anchorSize(to: self)
        
        cellView.addSubview(categoryTextField)
        
        left = categoryTextField.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10)
        left?.isActive = true
        categoryTextField.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        categoryTextField.trailingAnchor.constraint(equalTo: cellView.centerXAnchor, constant: 30).isActive = true

        cellView.addSubview(quantityLabel)

        quantityLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        right = quantityLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10)
        right?.isActive = true
    }
}
