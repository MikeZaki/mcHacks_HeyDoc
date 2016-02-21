//
//  MenuDataSource.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-16.
//  Copyright (c) 2016 Mike Zaki. All rights reserved.
//

import UIKit

class MenuDataSource : NSObject, UICollectionViewDelegate , UICollectionViewDataSource {
    
    typealias menuItemSelected = (Int) -> Void
    
    var menuCells:[MenuItemObject] = []
    var didSelectMenuItem:menuItemSelected!
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let menuItemCell = collectionView.dequeueReusableCellWithReuseIdentifier("menuCollectionViewCell", forIndexPath: indexPath) as! MenuCollectionViewCell
            populateCells(menuItemCell, index: indexPath.row)
        return menuItemCell
    }
    
    func populateCells(menuItemCell : MenuCollectionViewCell , index : Int) {
        let menuItem:MenuItemObject = MenuItemObject()
        menuItem.itemTitle = "View Medical File"
        menuItem.itemDescription = "Preview Your Medical Records, from your family prcatisioner"
        menuItem.itemImage = UIImage(named: "14490")
        
        menuCells.append(menuItem)
        
        menuItemCell.configureTheDamnCell(menuCells[index])
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        didSelectMenuItem(indexPath.row)
    }
}
