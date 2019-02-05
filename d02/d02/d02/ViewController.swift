//
//  ViewController.swift
//  d02
//
//  Created by Inti FRANC-REGIS on 2/4/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TabDeathNote: UITableView!{
        didSet {
            TabDeathNote.delegate = self
            TabDeathNote.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.deathdata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let DeathCell = tableView.dequeueReusableCell(withIdentifier: "DeathCell") as! DeathTableViewCell
        DeathCell.deathguy = Data.deathdata[indexPath.row]
        return DeathCell
    }
}

