//
//  Shape.swift
//  d06
//
//  Created by Inti FRANC-REGIS on 3/14/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class Shape: UIView {
    var type: String = "Rectangle"
    var collisionType: UIDynamicItemCollisionBoundsType = .rectangle
    override init(frame: CGRect) {
        super.init(frame: frame)
        bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        if (arc4random_uniform(2) == 0) {
            type = "Circle"
        }
        switch(arc4random_uniform(4)) {
        case 0:
            backgroundColor = UIColor.red
        case 1:
            backgroundColor = UIColor.green
        case 2:
            backgroundColor = UIColor.blue
        case 3:
            backgroundColor = UIColor.purple
        default:
            backgroundColor = UIColor.black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return collisionType
    }

    override var bounds: CGRect {
        get { return super.bounds }
        set(newBounds) {
            super.bounds = newBounds
            if (self.type == "Circle") {
                layer.cornerRadius = newBounds.size.width / 2.0
                self.collisionType = .ellipse
            }
        }
    }
}
