//
//  CustumCell.swift
//  d05
//
//  Created by Inti FRANC-REGIS on 2/28/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class CustumCell: UITableViewCell {

    @IBOutlet weak var Label: UILabel!
    
    var location : (Double, Double, String, String, UIColor)? {
        didSet {
            if let l = location {
                Label?.text = l.2
            }
        }
    }
}
