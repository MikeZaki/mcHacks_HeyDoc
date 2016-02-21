//
//  RealmObjects.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-19.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class realmTextObject: RLMObject {
    dynamic var englishText = ""
    dynamic var frenchText = ""
    
}

class realmSmoochObjext: RLMObject {
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var sex = ""
    dynamic var age = ""
}

