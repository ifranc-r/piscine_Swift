//
//  ViewController.swift
//  d03
//
//  Created by Inti FRANC-REGIS on 2/7/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    let urls = ["https://images-assets.nasa.gov/image/ARC-2006-ACD06-0145-065/ARC-2006-ACD06-0145-065~orig.jpg", "https://images-assets.nasa.gov/image/PIA15415/PIA15415~orig.jpg", "https://images-assets.nasa.gov/image/PIA17563/PIA17563~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collectcell", for: indexPath) as! CollectionViewCell
        cell.ImageView.downloaded(from: urls[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

