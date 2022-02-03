//
//  CustomCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 28/01/2022.
//

import UIKit


class CategoryCell: UITableViewCell {
    
    var oldLeftAnchor: NSLayoutConstraint?
    var newLeftAnchor: NSLayoutConstraint?
    var oldTrailingAnchor: NSLayoutConstraint?
    var newTrailingAnchor: NSLayoutConstraint?
    let move = 50
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.3
        view.layer.borderColor = ColorManager.cellBorder
        return view
    }()
    
        let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing == true {
            
        }
    }
    private func setupViews() {
        
        addSubview(cellBackgroundView)
        cellBackgroundView.anchorSize(to: self)

        cellBackgroundView.addSubview(cellView)
        
        cellView.anchorSize(to: cellBackgroundView)
        
        cellView.addSubview(categoryLabel)
//         old
//        categoryLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        
//        new
        oldLeftAnchor = categoryLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10)
        oldLeftAnchor?.isActive = true
        
        newLeftAnchor = categoryLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 60)
        newLeftAnchor?.isActive = false

      
        
        
        cellView.addSubview(quantityLabel)
//        quantityLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10).isActive = true
        quantityLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        //new
        oldTrailingAnchor = quantityLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10)
        oldTrailingAnchor?.isActive = true
        newTrailingAnchor = quantityLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -60)
        newTrailingAnchor?.isActive = false
        
        
    }
}
