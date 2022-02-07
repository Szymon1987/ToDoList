//
//  BaseCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 31/01/2022.
//

import UIKit

protocol BaseCellProtocol: AnyObject {
    func updateTitle(sender: BaseCell, title: String)
}

class BaseCell: UITableViewCell {
    
    weak var baseCellDelegate: BaseCellProtocol?
    var title: String?
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        textField.autocorrectionType = .no
        textField.isUserInteractionEnabled = false
    }
}

extension BaseCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {        
        if let title = title {
            baseCellDelegate?.updateTitle(sender: self, title: title)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text
        if let unwrappedTrimmedText = text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if unwrappedTrimmedText == "" {
                return false
            } else {
                title = unwrappedTrimmedText
                return textField.endEditing(true)
            }
        }
        return true

    }
    
}
