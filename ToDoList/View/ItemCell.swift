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
        colorView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
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
        textfield.backgroundColor = .yellow
        textfield.delegate = self
        return textfield
    }()
    
    
    
//    let circleView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    func drawCircle() {
//        let shapeLayer = CAShapeLayer()
////        let radious = circleView.frame.height / 2
//        let path = UIBezierPath(arcCenter: circleView.center, radius: 14, startAngle: 0, endAngle: .pi * 2, clockwise: true)
//
//        shapeLayer.path = path.cgPath
//        shapeLayer.lineWidth = 1
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeColor = ColorManager.roundedButton.cgColor
//        circleView.layer.addSublayer(shapeLayer)
//    }
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 2
        button.layer.borderColor = ColorManager.roundedButton.cgColor
        button.addTarget(self, action: #selector(cicrcleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 14
        return view
    }()
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0, options: []) {
            if self.isColorViewFilled == false {
                self.colorView.transform = .identity
            } else {
                self.colorView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            }
        }
    }
    
    @objc func cicrcleButtonTapped() {
        colorView.backgroundColor = ColorManager.roundedButton
        animate()
        isColorViewFilled.toggle()
    }
    
    func setupViews() {
        
        contentView.addSubview(itemTextField)
        
        itemTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60).isActive = true
        itemTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        itemTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        itemTextField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
  
        addSubview(colorView)
        colorView.trailingAnchor.constraint(equalTo: itemTextField.leadingAnchor, constant: -10).isActive = true
        colorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        addSubview(button)
        button.trailingAnchor.constraint(equalTo: itemTextField.leadingAnchor, constant: -10).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 28).isActive = true
        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        
//        addSubview(circleView)
//        circleView.trailingAnchor.constraint(equalTo: itemLabel.leadingAnchor).isActive = true
//        circleView.topAnchor.constraint(equalTo: itemLabel.centerYAnchor).isActive = true
//        circleView.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        circleView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
      
        
    }
    
    
}
    
    
