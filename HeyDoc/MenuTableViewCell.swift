//
//  MenuTableViewCell.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-21.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuItemImage: UIImageView!
    @IBOutlet weak var menuItemTitle: UILabel!

    
    func configureTheDamnCell(menuItem: MenuItemObject?){
        menuItemTitle.text = menuItem?.itemTitle
        menuItemImage.image = menuItem?.itemImage
    }
}
