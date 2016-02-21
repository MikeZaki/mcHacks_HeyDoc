//
//  RemoteNotificationDeepLink.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-21.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//
import UIKit

let RemoteNotificationDeepLinkAppSectionKey : String = "article"

class RemoteNotificationDeepLink: NSObject {
    
    var article : String = ""
    
    class func create(userInfo : [NSObject : AnyObject]) -> RemoteNotificationDeepLink?
    {
        let info = userInfo as NSDictionary
        
        var articleID = info.objectForKey(RemoteNotificationDeepLinkAppSectionKey) as! String
        
        var ret : RemoteNotificationDeepLink? = nil
        if !articleID.isEmpty
        {
            ret = RemoteNotificationDeepLinkArticle(articleStr: articleID)
        }
        return ret
    }
    
    private override init()
    {
        self.article = ""
        super.init()
    }
    
    private init(articleStr: String)
    {
        self.article = articleStr
        super.init()
    }
    
    final func trigger()
    {
        dispatch_async(dispatch_get_main_queue())
            {
                //NSLog("Triggering Deep Link - %@", self)
                self.triggerImp()
                    { (passedData) in
                        // do nothing
                }
        }
    }
    
    private func triggerImp(completion: ((AnyObject?)->(Void)))
    {
        
        completion(nil)
    }
}

class RemoteNotificationDeepLinkArticle : RemoteNotificationDeepLink
{
    var articleID : String!
    
    override init(articleStr: String)
    {
        self.articleID = articleStr
        super.init(articleStr: articleStr)
    }
    
    private override func triggerImp(completion: ((AnyObject?)->(Void)))
    {
        super.triggerImp()
            { (passedData) in
                
                var vc = UIViewController()
                
                // Handle Deep Link Data to present the Article passed through
                
                    vc = diagnoseResultsViewController()
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.addSubview(vc.view)
                
                completion(nil)
        }
    }
    
}

