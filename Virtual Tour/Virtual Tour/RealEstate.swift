//
//  RealEstate.swift
//  Virtual Tour
//
//  Created by Admin on 5/2/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import Foundation

class RealEstate {
    
    // properties and methods
    // attributes / properties
    var developer: String = "Eton Property"
    var name: String = "Reflections"
    var price: String = "From $395,000 with Car Park & Storage"
    var type: String = "Apartement"
    var location: String = "108 Haines Street, North Melbourne, Vic 3051"
    var phoneNumber: String = "tel://0413508866" 
    var website: String = "http://www.reflectionsnorthmelbourne.com.au/"
    var images: [ String: [String]] = [
        
        "fullsize": [
            "fullFrontview.jpg",
            "fullLounge.jpg",
            "fullLivingroom.jpg",
            "fullGarden.jpg",
            "fullKitchen.jpg",
            "fullBedroom.jpg",
            "fullBathroom.jpg",
            "fullSideview.jpg",
            "fullConservatory.jpg"
        ],
        
        "thumbnail" : [
            "thumbFrontview.jpg",
            "thumbLounge.jpg",
            "thumbLivingroom.jpg",
            "thumbGarden.jpg",
            "thumbKitchen.jpg",
            "thumbBedroom.jpg",
            "thumbBathroom.jpg",
            "thumbSideview.jpg",
            "thumbConservatory.jpg"
        ]
        
    ]
    
    
    // constructor default
    /* init(developer: String, name: String, description: String, price: String, type: String, location: String, image: [String]) {
        
        self.developer = developer
        self.name = name
        self.description = description
        self.price = price
        self.type = type
        self.location = location
        self.image = image
        
    } */
    
}
