//
//  ItemCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 31/01/2022.
//

import UIKit

protocol ItemCellProtocol: AnyObject {
    func updateItemTitle(itemTitle: String, indexPath: IndexPath)
        
}

class ItemCell: UITableViewCell, UITextFieldDelegate {

    weak var cellDelegate: ItemCellProtocol?
    var indexPath: IndexPath?

    var isColorViewFilled = false
    var itemTitle: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        checkmarkView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        self.selectionStyle = .none
//        drawCircle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if let itemTitle = itemTitle, let indexPath = indexPath {
            cellDelegate?.updateItemTitle(itemTitle: itemTitle, indexPath: indexPath)
        }

    }
    
    lazy var itemTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont.preferredFont(forTextStyle: .headline)
        textfield.delegate = self
        return textfield
    }()
    
    lazy var checkmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1.5
        button.layer.borderColor = ColorManager.roundedButton.cgColor
        button.addTarget(self, action: #selector(cicrcleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let checkmarkView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "checkmark"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    func animate() {
        UIView.animate(withDuration: 0.2, delay: 0, options: []) {
            if self.isColorViewFilled == false {
                self.checkmarkView.transform = .identity
            } else {
                self.checkmarkView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            }
        }
    }
    
    @objc func cicrcleButtonTapped() {
        checkmarkView.backgroundColor = ColorManager.roundedButton
        animate()
        isColorViewFilled.toggle()
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
        
        addSubview(checkmarkView)
        checkmarkView.trailingAnchor.constraint(equalTo: itemTextField.leadingAnchor, constant: -30).isActive = true
        checkmarkView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkmarkView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        checkmarkView.heightAnchor.constraint(equalToConstant: 32).isActive = true

    }
    
    
}
    
    

