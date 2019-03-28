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
        ScrollView.contentSize = (ImageView?.frame.size)!
        ScrollView.maximumZoomScale = 100
    }
    func setZoomScale() {
        
        var minZoom = min(self.view.bounds.size.width / ImageView!.bounds.size.width, self.view.bounds.size.height / ImageView!.bounds.size.height);
        
        if (minZoom > 1.0) {
            minZoom = 1.0;
        }
        ScrollView.minimumZoomScale = minZoom;
        ScrollView.zoomScale = minZoom;
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ImageView
    }
}
