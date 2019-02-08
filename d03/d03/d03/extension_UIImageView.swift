//
//  extension_UIImageView.swift
//  d03
//
//  Created by Inti FRANC-REGIS on 2/8/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
//    var activityInd:UIActivityIndicatorView = UIActivityIndicatorView()
//    func showSpinner() {
//        activityInd.center = self.center
//        activityInd.hidesWhenStopped = true
//        activityInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        self.addSubview(activityInd)
//        activityInd.startAnimating()
//        UIApplication.shared.beginIgnoringInteractionEvents()
//    }
//    func stopSpinner(){
//        activityInd.stopAnimating()
//        UIApplication.shared.endIgnoringInteractionEvents()
//    }
    
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
