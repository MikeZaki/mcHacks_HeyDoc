//
//  MenuItemObject.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-16.
//  Copyright (c) 2016 Mike Zaki. All rights reserved.
//

import UIKit
//Realm

class MenuItemObject {
    
    var itemImage : UIImage?
    var itemTitle : String?
    var itemDescription : String?
    
    required init() {
        itemDescription = ""
        itemImage = nil
        itemTitle = ""
    }
    
}
