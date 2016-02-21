//
//  RestAPIManager.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-20.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON , NSError) -> Void

class RestAPIManager: NSObject {
    
    static let sharedInstance = RestAPIManager()
    
    let baseURL = "http://api.randomuser.me/"
    
    func getRandomUser(onCompletion: (JSON) -> Void) {
        let route = baseURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request){ data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error!)
        }
        
        task.resume()
    }
    

    func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
        var err: NSError?
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        
        // Set the POST body for the request
        try! request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions.init(rawValue: 1))
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, err!)
        })
        task.resume()
    }
}
