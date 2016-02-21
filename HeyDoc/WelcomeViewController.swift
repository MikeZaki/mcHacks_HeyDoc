    //
//  WelcomeViewController.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-13.
//  Copyright (c) 2016 Mike Zaki. All rights reserved.
//
import UIKit
import Realm
import Alamofire
import RealmSwift
import SwiftyJSON

class WelcomeViewController : BaseViewController{
    
    @IBOutlet weak var welcomeLabel: MultiLanguageLabel!
    @IBOutlet weak var welcomeButton: UIButton!
    
    //populate From Realm not just typed in
    var languageArray : [String] = []
    let textString = "How Can I Help?, Comment puis-je aider ?"
    
    var RLMSymptoms = RLMArray(objectClassName: SymptomsObject.className())
    var RLMConditions = RLMArray(objectClassName: ConditionsObject.className())
    
    let thisRealm = try!Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeButton.titleLabel?.text = "Get Started"
        getInfermedicaInfo()
        languageLabelSettings()
    }
    
    func getInfermedicaInfo() {
        let keys = [
            "app_id": "78cbe111",
            "app_key": "a373cd244e6366d79f546f214b757361"
        ]
        
        Alamofire.request(.GET, Constants.symptomsURL, headers: keys).validate().responseJSON { (response) -> Void in
            switch (response.result){
            case .Success:
                if let value = response.result.value {
                    print("SUCESS")
                    let symptoms = JSON(value)
                    print(symptoms.count)
                    self.populateSymptomsRealm(symptoms)
                }
            case .Failure(let Error):
                print(Error)
            }
            
        }
        
        Alamofire.request(.GET, Constants.conditionsURL, headers: keys).validate().responseJSON { (response) -> Void in
            switch (response.result){
            case .Success:
                if let value = response.result.value {
                    print("SUCESS")
                    let conditions = JSON(value)
                    print(conditions.count)
                    self.populateConditionsRealm(conditions)
                }
            case .Failure(let Error):
                print(Error)
            }
            
        }
    }
    
    func populateSymptomsRealm(symptoms:JSON) -> Void {
        var storedSymptoms = thisRealm.objects(SymptomsObject)
        
        //if first run
        if storedSymptoms.count == 0{
            
            for var i = 0; i < symptoms.count; ++i {
                let newSymptom = SymptomsObject()
                newSymptom.name = symptoms[i]["name"].stringValue
                newSymptom.id = symptoms[i]["id"].stringValue
                //newSymptom.category =  symptoms[0]["name"].stringValue
                newSymptom.image_url = symptoms[i]["image_url"].stringValue
                newSymptom.parent_id = symptoms[i]["parent_id"].stringValue
                newSymptom.parent_relation = symptoms[i]["parent_relation"].stringValue
            
                try! thisRealm.write{
                    thisRealm.add(newSymptom)
                }
                
            }
            
            storedSymptoms = thisRealm.objects(SymptomsObject)
            print(storedSymptoms)
        }
    }
    
    func populateConditionsRealm(conditions:JSON) -> Void {
        var storedConditions = thisRealm.objects(ConditionsObject)
        
        //if first run
        if storedConditions.count == 0{
            
            for var i = 0; i < conditions.count; ++i {
                let newCondition = ConditionsObject()
                newCondition.name = conditions[i]["name"].stringValue
                newCondition.id = conditions[i]["id"].stringValue
                //newSymptom.category =  symptoms[0]["name"].stringValue
                newCondition.prevelance = conditions[i]["prevelance"].stringValue
                newCondition.acuteness = conditions[i]["acuteness"].stringValue
                newCondition.severity = conditions[i]["severity"].stringValue
                newCondition.sex_filter = conditions[i]["sex_filter"].stringValue

                
                try! thisRealm.write{
                    thisRealm.add(newCondition)
                }
            }
            
            storedConditions = thisRealm.objects(ConditionsObject)
            print(storedConditions)
        }
    }
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("HomeViewShow", sender: nil)
    }
    
    func languageLabelSettings() {
        languageArray = PreferenceUtility().populateLanguageArray(textString, intoArray: languageArray)
        //welcomeLabel.text = PreferenceUtility().compileTextForUserLanguage(languageArray)

    }
}
