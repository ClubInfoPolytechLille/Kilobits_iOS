//
//  StringExtension.swift
//  Kilobits_iOS
//
//  Created by Marianne on 04/03/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation

// Extension de String pour la localisation
extension String {
    
    
    /// Renvoie la version de la chaîne dans la langue actuelle dont on a appliqué localized() sur l'identifiant.
    ///
    /// - Parameter table: La table (fichier .strings sans l'extension) dans laquelle aller chercher la chaîne. nil pour aller la cherche dans le fichier par défaut (Locale.strings).
    /// - Returns: La chaîne dans la bonne langue.
    func localized(table: String?) -> String
    {
        let code = (UserDefaults.standard.object(forKey: "AppleLanguages") as! [String])[0]
        let path = Bundle.main.path(forResource: code, ofType: "lproj")
        return Bundle(path: path!)!.localizedString(forKey: self, value: "", table: table)
    }
}
