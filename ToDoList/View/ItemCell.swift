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
//        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1.5
        button.layer.borderColor = ColorManager.roundedButton.cgColor
        button.addTarget(self, action: #selector(checkmarkButtonTapped), for: .touchUpInside)
        let selectedImage = UIImage(named: "checkmark")
        let clearImage = UIImage(named: "clear")
        button.setImage(selectedImage, for: .selected)
        button.setImage(clearImage, for: .normal)
        return button
    }()
    
//    let checkmarkView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "checkmark"))
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.cornerRadius = 16
//        return imageView
//    }()
    
//    func animate() {
//        UIView.animate(withDuration: 2, delay: 0, options: []) {
//            self.checkmarkView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//            if self.checkmarkButton.isSelected {
//                self.checkmarkView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//            } else {
//                self.checkmarkView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
//            }
//        }
//    }

    
    @objc func checkmarkButtonTapped() {
//        animate()
        
        
//        self.cellDelegate?.toggleDone(sender: self)
        itemCellDelegate?.toggleDone(sender: self)
   
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 1.0)
    }

    override func setupViews() {
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
        
//        addSubview(checkmarkView)
//        checkmarkView.trailingAnchor.constraint(equalTo: itemTextField.leadingAnchor, constant: -30).isActive = true
//        checkmarkView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        checkmarkView.widthAnchor.constraint(equalToConstant: 32).isActive = true
//        checkmarkView.heightAnchor.constraint(equalToConstant: 32).isActive = true

    }
    
}
    

    

