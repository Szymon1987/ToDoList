//
//  CustomCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 28/01/2022.
//

import UIKit


class CustomCell: UITableViewCell {
    
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    func setupViews() {
        
        addSubview(cellBackgroundView)
        cellBackgroundView.anchorSize(to: self)

        cellBackgroundView.addSubview(cellView)
        
        cellView.anchorSize(to: cellBackgroundView)
        
        cellView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.3
        view.layer.borderColor = ColorManager.cellBorder
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
