//
//  PreferenceUtility.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-16.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import Foundation

public class PreferenceUtility {
    
    public enum UserLanguage {
        case English
        case French
    }
    
    public var currentLanguage: UserLanguage!
    
    required public init() {
        currentLanguage = UserLanguage.English
    }
    
    func getLanguage() -> UserLanguage {
        return self.currentLanguage
    }
    
    func populateLanguageArray (textString: String, var intoArray:[String]) -> [String]{
        intoArray = textString.componentsSeparatedByString(",")
        return intoArray
    }
    
    func compileTextForUserLanguage (languageArray: [String]) -> String {
        switch PreferenceUtility().getLanguage() {
            case .English: return languageArray[0]
            case .French: return languageArray[1]
        }
    }
    
    func populateUserDetails(fn:String, ln:String, age:Int, sex:String){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(fn, forKey: "firstName")
        defaults.setObject(ln, forKey: "lastName")
        defaults.setObject(age, forKey: "age")
        defaults.setObject(sex, forKey: "sex")
    }
    
}