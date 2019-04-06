//
//  ViewController.swift
//  d07
//
//  Created by Inti FRANC-REGIS on 3/27/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController {

    @IBOutlet weak var LabelMeteo: UILabel!
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var Label: UILabel!
    var bot : RecastAIClient?
    let client = DarkSkyClient(apiKey: "589b61d2d28d599414ee6be6d50b65b8")
    
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
        getLocation(question: message)
        conversation(message: message)
    }
    func getLocation(question: String) {
        bot?.textRequest(question, successHandler: { response in
            guard let location = response.get(entity: "location") else {return}
//            guard let latitude = location["lat"] as? Double else { return }
//            guard let longitude = location["lng"] as? Double else { return }
//            guard let raw = location["raw"] as? String else { return }
            
            print(location)
            self.LabelMeteo.text = location["formatted"] as? String
            self.getSummary(latitude: (location["lat"]as? Double)!, longitude: (location["lng"]as? Double)!)
        }) { error in
            print(error) }
    }
    func conversation(message:String) {
        print(message)
        bot?.textConverse(message, successHandler: { response in
            guard let intents = response.intents else { return }
            guard let replies = response.replies else { return }
            guard let language = response.language else { return }
            guard let entities = response.entities else { return }
            print("\n\n")

            if (intents.count > 0){
                guard let intent = intents[0] as? Dictionary<String, AnyObject> else { return }
                self.Label.text = intent["description"] as? String ?? "Error"
            }else {
                self.Label.text = "Error"
            }
            print(replies)
            print(language)
            print(entities)
        }) { error in
            self.Label.text = "Error"
            print(error)
        }
    }
    func getSummary(latitude: Double, longitude: Double) {
        client.getForecast(latitude: latitude, longitude: longitude, completion: { result in
            switch result {
            case .success(let forecast, _):
                DispatchQueue.main.async {
                    self.LabelMeteo.text = "It's \((forecast.currently?.summary)!) in \(self.LabelMeteo.text!)"
                    print(forecast.currently?.summary ?? "No")
                }
            case .failure(let error):
                DispatchQueue.main.async { print(error) }
            }
        })
    }
    
}

