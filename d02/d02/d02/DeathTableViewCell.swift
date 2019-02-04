//
//  DeathTableViewCell.swift
//  d02
//
//  Created by Inti FRANC-REGIS on 2/4/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class DeathTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var NameDeathLabel: UILabel!
    
    var deathguy : (String, Date, String)? {
        didSet {
            if let tmp = deathguy {
                NameDeathLabel?.text = tmp.0
                dateLabel?.text = tmp.1.toString(dateFormat: "dd MM yyyy")
            }
        }
    }
}
