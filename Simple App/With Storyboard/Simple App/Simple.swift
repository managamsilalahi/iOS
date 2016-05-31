//
//  DataObject.swift
//  Simple App
//
//  Created by Admin on 5/24/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import SwiftyJSON

class Simple {
    
    var id: Int!
    var caption: String!
    var imageURL: String!
    var description: String!
    
    required init(json: JSON) {
        self.id = json["id"].intValue
        self.caption = json["caption"].stringValue
        self.imageURL = json["image_url"].stringValue
        self.description = json["description"].stringValue
    }
    
}
