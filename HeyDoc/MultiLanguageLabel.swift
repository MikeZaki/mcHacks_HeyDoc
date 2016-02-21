//
//  MultiLanguageLabel.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-16.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit

class MultiLanguageLabel: UILabel{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let preferenctUtility = PreferenceUtility()
    var currentLanguage: PreferenceUtility.UserLanguage { didSet{ setNeedsLayout()} }
    
    required init?(coder aDecoder: NSCoder) {
        currentLanguage = PreferenceUtility().getLanguage()
        super.init(coder: aDecoder)
    }
    
}
