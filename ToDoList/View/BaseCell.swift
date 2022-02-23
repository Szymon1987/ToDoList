//
//  BaseCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 31/01/2022.
//

import UIKit

protocol BaseCellProtocol: AnyObject {
    func updateUI(sender: BaseCell, title: String)
}

class BaseCell: UITableViewCell {
    
    weak var baseCellDelegate: BaseCellProtocol?
//    var title: String?
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .label
        textField.font = UIFont.preferredFont(forTextStyle: .headline)
        textField.delegate = self
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = ColorManager.cellBackground
        textField.autocorrectionType = .no
        textField.isUserInteractionEnabled = false
    }
}
    //MARK: - Textfield Delegate

extension BaseCell: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let trimmedTitle = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        textField.text = trimmedTitle
        if trimmedTitle == nil || trimmedTitle == "" {
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let title = textField.text {
            baseCellDelegate?.updateUI(sender: self, title: title)
        }
    }
    
    
    
}



//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let title = title {
//            baseCellDelegate?.updateUI(sender: self, title: title)
//        }
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let text = textField.text
//        if let unwrappedTrimmedText = text?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            if unwrappedTrimmedText == "" {
//                print("Fired empty")
//                return false
//            } else {
//                title = unwrappedTrimmedText
//                return textField.endEditing(true)
//            }
//        }
//        return true
//    }
