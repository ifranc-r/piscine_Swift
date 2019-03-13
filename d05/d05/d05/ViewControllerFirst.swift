//
//  ViewControllerFirst.swift
//  d05
//
//  Created by Inti FRANC-REGIS on 2/28/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class ViewControllerFirst: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdCell") as! CustumCell
        cell.location = Data.locations[indexPath.row]
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(Data.locations[indexPath.row].2)
        let tab = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarControllerCustum
        tab.selectedIndex = 1
        let vcSecond = tab.viewControllers![1] as! ViewControllerSecond
        vcSecond.select_annotation(index: indexPath.row)
        present(tab, animated: true, completion: nil)
    }
}
