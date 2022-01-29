//
//  CustomCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 28/01/2022.
//

import UIKit


class CustomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
  
    func setupViews() {
        addSubview(cellView)
        cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        cellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        cellView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    
        
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
