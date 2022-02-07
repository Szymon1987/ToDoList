//
//  CustomCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 28/01/2022.
//

import UIKit

class CategoryCell: BaseCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.3
        view.layer.borderColor = ColorManager.cellBorder
        return view
    }()

    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()

        addSubview(cellView)
        
        cellView.anchorSize(to: self)
        
        cellView.addSubview(textField)

        textField.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        textField.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: cellView.centerXAnchor, constant: 30).isActive = true

        cellView.addSubview(quantityLabel)

        quantityLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        quantityLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
    }
}
