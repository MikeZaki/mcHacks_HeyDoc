//
//  BaseViewController.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-18.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //errase any recreatable resources
    }
}
