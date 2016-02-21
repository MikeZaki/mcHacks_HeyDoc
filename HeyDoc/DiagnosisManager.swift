//
//  DiagnosisManager.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-21.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import Realm
import RealmSwift
import Alamofire
import SwiftyJSON

class DiagnosisManager {
    
    let thisRealm = try!Realm()
    
    func populateDiagnosticQuery (textString: String, var intoArray:[String]) -> [String]{
        intoArray = textString.componentsSeparatedByString(" ")
        return intoArray
    }
    
    func evaluateQuerry(diagnosticQueryWords:[String]) -> Void{
        var symptomNames:[String] = []
        var matchedSymptoms:[String] = []
        var matchedConditions:[String] = []
        
        let symptoms = thisRealm.objects(SymptomsObject)
        for symptom in symptoms {
            let name:String = symptom.name
            symptomNames.append(name)
        }
        var conditionNames:[String] = []
        let conditions = thisRealm.objects(ConditionsObject)
        for condition in conditions {
            let name:String = condition.name
            conditionNames.append(name)
        }
        
            for name in symptomNames {
                for word in diagnosticQueryWords {
                    if word.characters.count < 3 {
                        
                    }else if name .containsString(word) {
                        matchedSymptoms.append(name)
                    }
                }
            }
            for name in conditionNames {
                for word in diagnosticQueryWords {
                    if word.characters.count < 3 {
                    
                    }else if name .containsString(word) {
                        matchedConditions.append(name)
                    }
                }
            }
        let matchedIds = self.findId(matchedSymptoms)
        self.getFirstDiagnosis(getEvidenceArray(matchedIds))
    }
    
    func getEvidenceArray(matchedId:[String]) -> [[String:AnyObject]]{
        var evidence:[[String:AnyObject]] = []
        for id in matchedId {
            let anEvidence = ["id":id, "choice_id":"present"]
            evidence.append(anEvidence)
        }
        
        return evidence
    }
    
    func getFirstDiagnosis(evidence:[[String:AnyObject]]){
        let keys = [
            "app_id": "78cbe111",
            "app_key": "a373cd244e6366d79f546f214b757361"
        ]
        let defaults = NSUserDefaults.standardUserDefaults()
        let age = defaults.objectForKey("age") ?? 0
        let sex = defaults.stringForKey("sex") ?? ""
        let paramaters = [
            "sex" : sex,
            "age": age!,
            "evidence": evidence
        ]
        print(evidence)
        Alamofire.request(.POST, "https://api.infermedica.com/v1/diagnosis", headers: keys, parameters: paramaters, encoding: .JSON).validate().responseJSON{ (response) -> Void in
            switch (response.result){
            case .Success:
                if let value = response.result.value {
                    print("SUCESS")
                    let results = JSON(value)
                    let currentprobability = results["conditions"][0]["probability"].stringValue
                    let diagnosisName = results["conditions"][0]["name"].stringValue
                    SKTUser.currentUser().addProperties(["currentCondition": diagnosisName, "currentProbability":currentprobability])
                    Smooch.track("SentDignosisRequest");
                }
            case .Failure(let Error):
                print(Error)
            }
        }
    }
    
    func populateDiagnosisRealm(diagnosis: JSON){
        
    }
    
    func findId(matchedName:[String]) -> [String]{
        var successfullIds:[String] = []
        let symptoms = thisRealm.objects(SymptomsObject)
        for symptom in symptoms {
            for name in matchedName{
            let symptomName:String = symptom.name
                if name == symptomName {
                    successfullIds.append(symptom.id)
                }
            }
        }
        return successfullIds
    }
}

