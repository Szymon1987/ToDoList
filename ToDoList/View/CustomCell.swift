//
//  CustomCell.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 28/01/2022.
//

import UIKit
import SwipeCellKit

class CustomCell: SwipeCollectionViewCell {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        print("Cos")
        backgroundColor = .red
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
  
}
