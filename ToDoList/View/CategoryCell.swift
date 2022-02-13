//
//  CustomCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 28/01/2022.
//

import UIKit

class CategoryCell: BaseCell {
    
//    let cellView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 8
//        view.layer.borderWidth = 0.3
//        view.layer.borderColor = ColorManager.cellBorder
//        return view
//    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        layer.masksToBounds = false
        layer.cornerRadius = 8
        contentView.layer.borderWidth = 0.3
        contentView.layer.borderColor = ColorManager.cellBorder
    }
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.trackTintColor = ColorManager.viewBackground
        progressView.progressTintColor = ColorManager.roundedButton
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0
        return progressView
    }()
    
    override func setupViews() {
        super.setupViews()

//        addSubview(cellView)
//
//        cellView.anchorSize(to: self)
//
//        cellView.addSubview(textField)
//        textField.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
//        textField.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
//        textField.trailingAnchor.constraint(equalTo: cellView.centerXAnchor, constant: 30).isActive = true
//
//        cellView.addSubview(quantityLabel)
//        quantityLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
//        quantityLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
//
//        cellView.addSubview(progressView)
//        progressView.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
//        progressView.trailingAnchor.constraint(equalTo: quantityLabel.trailingAnchor).isActive = true
//        progressView.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 10).isActive = true
        
        


//        contentView.layer.masksToBounds = true
//        contentView.layer.cornerRadius = 8
//        layer.masksToBounds = false
//        layer.cornerRadius = 8
//
//        contentView.layer.borderWidth = 0.3
//        contentView.layer.borderColor = ColorManager.cellBorder
//
        addSubview(textField)
        
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 30).isActive = true
        
        addSubview(quantityLabel)
        quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        quantityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        addSubview(progressView)
        progressView.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: quantityLabel.trailingAnchor).isActive = true
        progressView.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 10).isActive = true
    }
}
