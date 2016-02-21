//
//  MedicalCategoryManager.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-20.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class MedicalCategoryManager {
    var categories = RLMArray(objectClassName: Category.className())
    var categoryNames:[String] = []
    
    func populateDefaultCategories() {
        var categories = Category.allObjects() //1
        
        if categories.count == 0 { //2
            let realm = RLMRealm.defaultRealm() //3
            realm.beginWriteTransaction() //4
            
            //5
            let defaultCategories = ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ]
            for category in defaultCategories {
                //6
                let newCategory = Category()
                newCategory.name = category
                realm.addObject(newCategory)
            }
            
            try! realm.commitWriteTransaction() // 7
            categories = Category.allObjects() //8
        }
    }
}
