//
//  ScrollView.swift
//  d03
//
//  Created by Inti FRANC-REGIS on 2/26/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class ScrollView: UIViewController, UIScrollViewDelegate {
    
    var ImageView : UIImageView?
    var Image : UIImage?
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView = UIImageView(image: Image)
        ScrollView.addSubview(ImageView!)
    }
    
}
