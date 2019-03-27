//
//  ViewController.swift
//  d07
//
//  Created by Inti FRANC-REGIS on 3/27/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit
import RecastAI

class ViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var Label: UILabel!
    var bot : RecastAIClient?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bot = RecastAIClient(token : "936c8f1bd2898de786b01491d18d2af8", language: "en")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ButtonToSend(_ sender: Any) {
        let message = TextField.text!
//        getLocation(question: message)
        conversation(message: message)
    }
    func getLocation(question: String) {
        bot?.textRequest(question, successHandler: { response in
            guard let location = response.get(entity: "location") else {return}
//            guard let latitude = location["lat"] as? Double else { return }
//            guard let longitude = location["lng"] as? Double else { return }
//            guard let raw = location["raw"] as? String else { return }
            
            print(location)
        }) { error in
            print(error) }
    }
    func conversation(message:String) {
        print(message)
        bot?.textConverse(message, successHandler: { response in
            guard let intents = response.intents as? Dictionary<String, AnyObject> else { return }
            guard let replies = response.replies else { return }
            guard let language = response.language else { return }
            
            print("\n\n")
            if (intents.count > 0){
                self.Label.text = intents[0]["description"] as? String ?? "Error"
            }else {
                self.Label.text = "Error"
            }
            print(replies)
            print(language)
        }) { error in
            self.Label.text = "Error"
            print(error)
        }
    }
}

