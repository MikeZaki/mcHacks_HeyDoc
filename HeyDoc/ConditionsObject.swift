//
//  ConditionsObject.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-20.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ConditionsObject: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var categories = Category?()
    dynamic var prevelance = ""
    dynamic var acuteness = ""
    dynamic var severity = ""
    dynamic var sex_filter = ""
}
