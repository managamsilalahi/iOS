//
//  Restaurant.swift
//  FoodPin
//
//  Created by Admin on 3/22/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {
//    properties and methods
    
//    Atribut / properties
    @NSManaged var name: String!
    @NSManaged var type: String!
    @NSManaged var location: String!
    @NSManaged var image: NSData!
    @NSManaged var isVisited: NSNumber!
    
//    Constructor default
    /*
    init(name: String, type: String, location: String, image: NSData, isVisited: NSNumber) {
        
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        
    }*/
    
    
    
}
