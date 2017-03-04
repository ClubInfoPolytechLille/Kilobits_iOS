//
//  StringExtension.swift
//  Kilobits_iOS
//
//  Created by Marianne on 04/03/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation

extension String {
    
    func localized(table: String?) -> String
    {
        let code = (UserDefaults.standard.object(forKey: "AppleLanguages") as! [String])[0]
        let path = Bundle.main.path(forResource: code, ofType: "lproj")
        return Bundle(path: path!)!.localizedString(forKey: self, value: "", table: table)
    }
}
