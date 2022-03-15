//
//  CustomCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 28/01/2022.
//

import UIKit

class CategoryCell: BaseCell {
    
    //MARK: - UIComponents
    
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorManager.cellBackground
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.3
        view.layer.borderColor = ColorManager.cellBorder
        return view
    }()
    
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
    
    // MARK: - Views set up methods
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(cellBackgroundView)
        cellBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cellBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
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
