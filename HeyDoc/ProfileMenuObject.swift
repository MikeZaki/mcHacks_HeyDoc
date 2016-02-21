//
//  ProfileMenuObject.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-20.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit
//Realm

class ProfileMenuItemObject : MenuItemObject {
    
    var settingsName : MultiLanguageLabel?
    
    required init() {
        settingsName?.text = ""
    }
    
}
