//
//  ImagesViewController.swift
//  ImageSearch
//
//  Created by Mobile Team 3 on 12/12/17.
//  Copyright © 2017 Mobile Team 3. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController,UICollectionViewDataSource {
    var networkManager:NetworkManager?
    var flickr:Flickr?
    var searchTerm: String?
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    override func viewDidLoad()->() {
        super.viewDidLoad()
        networkManager = NetworkManager()
        networkManager?.getImages(searchTerm: searchTerm ?? "India",completion: { (flickr) in print("Printing flickr object received from network")
            print(flickr!)
            self.flickr = flickr
            DispatchQueue.main.async {
                self.imagesCollectionView.reloadData()
            }
        })
        self.imagesCollectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return flickr?.photos?.photo?.count ?? 0
        
    }
    let imageCache = NSCache<AnyObject, AnyObject>()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = cell.viewWithTag(101) as? UIImageView
        let image = flickr?.photos?.photo?[indexPath.row].url_s
        let  imageURL = URL(string : image!)
        
        if let imageFromCache = imageCache.object(forKey: image! as AnyObject) as? UIImage {
            DispatchQueue.main.async{imageView?.image = imageFromCache}
        } else {
            print("imageURL \(imageURL)")
            DispatchQueue.global().async {
                let imageData = try? Data(contentsOf: imageURL!)
                let imageImage = UIImage(data: imageData!)
                self.imageCache.setObject(imageImage!, forKey: image! as AnyObject)
                DispatchQueue.main.async{imageView?.image = imageImage!}
            }
            imageView?.image = UIImage(named: "placeholder")
        }
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
}
