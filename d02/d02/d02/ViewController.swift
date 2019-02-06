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
    var deathdata : [(String, Date, String)] = Data.deathdata
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deathdata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let DeathCell = tableView.dequeueReusableCell(withIdentifier: "DeathCell") as! DeathTableViewCell
        DeathCell.deathguy = self.deathdata[indexPath.row]
        return DeathCell
    }
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "addPerson"{
            print(segue.identifier!)
            self.TabDeathNote?.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

