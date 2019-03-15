//: Playground - noun: a place where people can play

import UIKit
import Foundation

let myUid = "81482306e910c0eef6bd0680061030f0dd56adeadeaac333e37e28d9bc4b3f18"
let mySecret = "7745360d50babd280161bbc74a6acbb6b007586b1ea21a3a189498f603e4acc4"
let post_token = "grant_type=client_credentials&client_id=\(myUid)&client_secret=\(mySecret)"
let url = URL(string : "https://api.intra.42.fr/oauth/token")

var urlRequest = URLRequest(url: url!)

urlRequest.httpMethod = "POST"
urlRequest.httpBody = post_token.data(using: .utf8)

// set up the session
let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

let task = session.dataTask(with: urlRequest) {
    (data, response, error) in
    if let err = error {
        print(err)
    }
    else if let d = data {
        do {
//            let dic = try JSONSerialization.jsonObject(with: d, options: [])
            print(d)
        }
//        catch (let err){
//            print(err)
//        }
    }
}
task.resume()
