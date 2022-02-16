//
//  ItemCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 31/01/2022.
//

import UIKit

protocol ItemCellProtocol: AnyObject {
    func toggleDone(sender: ItemCell)
}

class ItemCell: BaseCell {
    
    weak var itemCellDelegate: ItemCellProtocol?

    lazy var checkmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1.5
        button.layer.borderColor = ColorManager.checkmarkButton.cgColor
        button.addTarget(self, action: #selector(checkmarkButtonTapped), for: .touchUpInside)
        let selectedImage = UIImage(named: "checkmark")
        let clearImage = UIImage(named: "clear")
        button.setImage(selectedImage, for: .selected)
        button.setImage(clearImage, for: .normal)
        return button
    }()

    
    @objc func checkmarkButtonTapped() {
        if textField.isEditing == false {
            itemCellDelegate?.toggleDone(sender: self)
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred(intensity: 1.0)
            textField.endEditing(true)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        self.selectionStyle = .none
        contentView.addSubview(textField)
        
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80).isActive = true
        textField.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
   
        addSubview(checkmarkButton)
        checkmarkButton.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -30).isActive = true
        checkmarkButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkmarkButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        checkmarkButton.heightAnchor.constraint(equalToConstant: 32).isActive = true

    }
    
}
    

    

