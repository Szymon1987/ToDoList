//
//  ItemCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 31/01/2022.
//

import UIKit

protocol ItemCellProtocol: AnyObject {
    func updateItemTitle(sender: ItemCell, title: String)
    func toggleDone(sender: ItemCell)
}

class ItemCell: UITableViewCell {

    weak var cellDelegate: ItemCellProtocol?
    var itemTitle: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.selectionStyle = .none
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var itemTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .headline)
        textField.delegate = self
        return textField
    }()
    
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
        
        
        self.cellDelegate?.toggleDone(sender: self)
   
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 1.0)
    }

    func setupViews() {
        
        contentView.addSubview(itemTextField)
        
        itemTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80).isActive = true
        itemTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        itemTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        itemTextField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
   
        addSubview(checkmarkButton)
        checkmarkButton.trailingAnchor.constraint(equalTo: itemTextField.leadingAnchor, constant: -30).isActive = true
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
    

extension ItemCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let itemTitle = itemTitle {
            cellDelegate?.updateItemTitle(sender: self, title: itemTitle)
            print("called")
        
        }
          
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        let text = textField.text
        if let unwrappedTrimmedText = text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if unwrappedTrimmedText == "" {
                return false
            } else {
                itemTitle = unwrappedTrimmedText
                return itemTextField.endEditing(true)
            }
        }
        return true

    }
    
}
    

