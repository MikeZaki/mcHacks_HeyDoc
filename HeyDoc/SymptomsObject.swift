//
//  SymptomsObject.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-20.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class SymptomsObject: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var category = Category?()
    dynamic var image_url = ""
    dynamic var parent_id = ""
    dynamic var parent_relation = ""
    dynamic var children = ""
}
