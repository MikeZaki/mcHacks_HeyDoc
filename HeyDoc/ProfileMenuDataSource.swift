//
//  ProfileMenuDataSource.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-20.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit

class ProfileMenuDataSource : NSObject , UITableViewDelegate , UITableViewDataSource {
    
    typealias profileItemSelected = (Int) -> Void
    
    var profileCells:[ProfileMenuItemObject] = []
    var didSelectMenuItem:profileItemSelected!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        createCells()
        return profileCells.count
    }
    
    func createCells(){
        let menuItem:ProfileMenuItemObject = ProfileMenuItemObject()
        menuItem.itemTitle = "View Medical File"
        menuItem.itemImage = UIImage(named: "Folder")
        profileCells.append(menuItem)
        
        let menuItem2:ProfileMenuItemObject = ProfileMenuItemObject()
        menuItem.itemTitle = "View Medical"
        menuItem.itemImage = UIImage(named: "Folder")
        profileCells.append(menuItem2)
        
        let menuItem3:ProfileMenuItemObject = ProfileMenuItemObject()
        menuItem.itemTitle = "View Medical File"
        menuItem.itemImage = UIImage(named: "Folder")
        profileCells.append(menuItem3)
        
        let menuItem4:ProfileMenuItemObject = ProfileMenuItemObject()
        menuItem.itemTitle = "View Medical File"
        menuItem.itemImage = UIImage(named: "Folder")
        profileCells.append(menuItem4)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let menuItemCell = tableView.dequeueReusableCellWithIdentifier("profileCell1", forIndexPath: indexPath) as! MenuTableViewCell
        populateCells(menuItemCell, index: indexPath.row)
        return menuItemCell
    }
    
    func populateCells(menuItemCell : MenuTableViewCell , index : Int) {
        
        menuItemCell.configureTheDamnCell(profileCells[index])
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
//        didSelectMenuItem(indexPath.row)
//    }
}

