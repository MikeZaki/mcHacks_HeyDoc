//
//  tutorialViewController.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-21.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit
import Realm

class TutorialViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var ageField: UITextField?
    @IBOutlet weak var sexField: UITextField?
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var signupLabel: UILabel!
    
    @IBOutlet weak var getStartedButton: UIButton!
    var hasFirstName = false
    var pageIndex:Int!
    var titleIndex:String!
    var imageFile:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("firstName")
        {
            if name.characters.count > 3{
                self.hasFirstName = true
                getStartedButton.titleLabel?.text = "Skip Registration"
                self.onGetStartedButtonPressed(getStartedButton)
            }else{
                self.hasFirstName = false
                signupLabel.text = ""
            }
        }else{
            self.hasFirstName = false
            signupLabel.text = ""
        }
        
        self.titleLabel.text = titleIndex
        self.firstName.text = "First Name"
        self.lastNameLabel.text = "Last Name"
        self.sexLabel.text = "Sex"
        self.ageLabel.text = "Age"

    }
    
    @IBAction func onGetStartedButtonPressed(sender: UIButton) {
        if (self.hasFirstName){
            performSegueWithIdentifier("Show Welcome", sender: nil)
        }else{
            if let sex = sexField!.text {
                if let age = ageField!.text {
                    SKTUser.currentUser().addProperties(["sex" : sex , "age" : age])
                    print(sex)
                    print(age)
                }else{
                    //alert
                }
            }else{
                //alert
            }
            let Age = ageField!.text!
            let intAge = Int(Age)
            PreferenceUtility().populateUserDetails(firstNameField!.text!, ln: lastNameField!.text!, age: intAge as Int!, sex: sexField!.text!)
            Smooch.newConversationViewController()
        }
        performSegueWithIdentifier("Show Welcome", sender: nil)
    }
}
    
    

