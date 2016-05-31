//
//  GalleryViewController.swift
//  Virtual Tour
//
//  Created by Admin on 5/3/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit
import INSPhotoGallery

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    let etonProperty = RealEstate()
    
    var photos: [INSPhotoViewable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        for i in 0 ... 8 {
            
            photos.append (
                INSPhoto(image: UIImage(named: etonProperty.images["fullsize"]![i])!, thumbnailImage: UIImage(named: etonProperty.images["thumbnail"]![i])!)
            )
            
            // print(etonProperty.images["fullsize"]![i])
            // print(etonProperty.images["thumbnail"]![i])
            // print(photos)
            
        }
        
        
        for i in 0 ... photos.count - 1 {
            
            let photo = photos[i] as? INSPhoto
            let caption = etonProperty.images["fullsize"]![i]
            
            let range = caption.startIndex.advancedBy(4) ..< caption.endIndex.advancedBy(-4)
            
            photo!.attributedTitle = NSAttributedString(string: caption.substringWithRange(range), attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
            
        }
        
        
        /* for photo in photos {
            
            if let photo = photo as? INSPhoto {
                
                photo.attributedTitle = NSAttributedString(string: "Caption", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
                
            }
            
        } */
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}





extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        
        cell.populateWithPhoto(photos[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = galleryCollectionView.cellForItemAtIndexPath(indexPath) as! GalleryCollectionViewCell
        
        let currentPhoto = photos[indexPath.row]
        
        let galleryPreview = INSPhotosViewController(photos: photos, initialPhoto: currentPhoto, referenceView: cell)
        
        galleryPreview.referenceViewForPhotoWhenDismissingHandler = {
            [weak self] photo in
            
            if let index = self?.photos.indexOf({$0 === photo}) {
                
                let indexPath = NSIndexPath(forItem: index, inSection: 0)
                
                return self!.galleryCollectionView.cellForItemAtIndexPath(indexPath) as? GalleryCollectionViewCell
            }
            
            return nil
            
        }
        
        presentViewController(galleryPreview, animated: true, completion: nil)
        
    }
    
    
}
