//
//  ViewController.swift
//  d03
//
//  Created by Inti FRANC-REGIS on 2/7/19.
//  Copyright © 2019 Inti FRANC-REGIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    let urls = ["https://images-assets.nasa.gov/image/ARC-2006-ACD06-0145-065/ARC-2006-ACD06-0145-065~orig.jpg", "https://images-assets.nasa.gov/image/PIA15415/PIA15415~orig.jpg", "https://images-assets.nasa.gov/image/PIA17563/PIA17563~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~orig.jpg", "https://images-assets.nasa.gov/image/PIA16008/PIA16008~or" ]
    
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
        let url = URL(string:urls[indexPath.item])!
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                cell.loader.stopAnimating()
                cell.loader.hidesWhenStopped = true
                cell.ImageView.image = UIImage(data: data)
                if cell.ImageView.image == nil {
                    let alertController = UIAlertController(title: "Error", message: "Cannot acces to \(url.absoluteString)", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    cell.layer.borderColor = (UIColor.red.cgColor)
                    cell.layer.backgroundColor = (UIColor.red.cgColor)
                }
            }
        }).resume()
        cell.loader.startAnimating()
        cell.loader.hidesWhenStopped = false
        cell.layer.backgroundColor = (UIColor.white.cgColor)
        cell.layer.borderColor = (UIColor.black.cgColor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IdentifierCell"{
            let seq = segue.destination as! ScrollView
            let cell = sender as! CollectionViewCell
            if cell.ImageView.image != nil {
                seq.Image = cell.ImageView.image!
            } else {
                let alertController = UIAlertController(title: "Error", message: "Cannot acces to this image", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

