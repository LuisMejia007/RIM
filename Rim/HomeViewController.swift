//
//  HomeViewController.swift
//  Rim
//
//  Created by Chatan Konda on 9/13/17.
//  Copyright © 2017 Apple. All rights reserved.


import UIKit
import Firebase
import FirebaseDatabase


class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var arrayofIcons = [UIImage]()
    var arrayofIDs = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        arrayofIcons = [#imageLiteral(resourceName: "Contacts"), #imageLiteral(resourceName: "Save")]
        arrayofIDs = ["A","B"]
        
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayofIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = arrayofIcons[indexPath.row]
        
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let name = arrayofIDs[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: name)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    

 
 

}
