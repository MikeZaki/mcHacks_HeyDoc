//
//  MenuCollectionViewCell.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-16.
//  Copyright (c) 2016 Mike Zaki. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuItemTitle: MultiLanguageLabel!
    @IBOutlet weak var menuItemImage: UIImageView!

    func configureTheDamnCell(menuItem: MenuItemObject?){
        menuItemTitle.text = menuItem?.itemTitle
        menuItemImage.image = menuItem?.itemImage
    }
}

