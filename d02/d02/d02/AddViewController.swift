//
//  AddViewController.swift
//  d02
//
//  Created by Inti FRANC-REGIS on 2/6/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var DatePieker: UIDatePicker!

    @IBOutlet weak var DescribTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatePieker.minimumDate = Date()
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButton))
        self.navigationItem.rightBarButtonItem = addButton
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPerson"{
            if let vc = segue.destination as? ViewController{
                vc.deathdata.insert(((NameTextField?.text)!, DatePieker.date, (DescribTextView?.text)!), at:0)
                print(NameTextField?.text ?? "nothing")
                print(DatePieker.toString(dateFormat:"d MMMM yyyy HH:mm:ss"))
                print(DescribTextView?.text ?? "")
                
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton() {
        performSegue(withIdentifier: "addPerson", sender: self)
    }
}

extension UIDatePicker{
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self.date)
    }
}
