//
//  RestApiManager.swift
//  Simple App
//
//  Created by Admin on 5/24/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://www.mocky.io/v2/57321c550f00005307ead708"
    
    func getRandomData(onCompletion: (JSON) -> Void) {
        
        let route = baseURL
        makeHTTPGetRequest(route, onCompletion: {json, error in
            onCompletion(json as JSON)
        })
    }
    
    // MARK: Perform a GET Request
    private func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let jsonData = data {
                let json: JSON = JSON(data: jsonData)
                onCompletion(json, error)
            } else {
                onCompletion(nil, error!)
            }
            
        })
        
        task.resume()
        
    }
    
    // MARK: Perform a POST Request
    private func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        
        do {
            
            // Set the POST body for the request
            let jsonBody = try NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted)
            
            request.HTTPBody = jsonBody
            
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                
                if let jsonData = data {
                    let json: JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error!)
                }
                
            })
            
            task.resume()
            
        } catch {
            // Create your personal error
            onCompletion(nil, nil)
            
        }
        
    }
    
}
