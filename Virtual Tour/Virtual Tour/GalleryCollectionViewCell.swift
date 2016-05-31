//
//  GalleryCollectionViewCell.swift
//  Virtual Tour
//
//  Created by Admin on 5/3/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit
import INSPhotoGallery

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageGallery: UIImageView!
    
    func populateWithPhoto(photo: INSPhotoViewable) {
        
        photo.loadThumbnailImageWithCompletionHandler { [weak photo](image, error) in
            
            if let image = image {
                if let photo = photo as? INSPhoto {
                    photo.thumbnailImage = image
                }
                self.imageGallery.image = image
                self.imageGallery.layer.cornerRadius = self.imageGallery.frame.size.width / 2;
                self.imageGallery.clipsToBounds = true;
            }
        }
    }
    
}
