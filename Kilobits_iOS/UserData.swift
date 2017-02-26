//
//  UserData.swift
//  Kilobits_iOS
//
//  Created by Marianne on 19/02/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserData
{
    var pseudo: String!
    var nom: String?
    var prenom: String?
    var mdp: String!
    var ville: String?
    var estMobile: Bool?
    var typ: Bool?
    var divers: String?
    var dispo: Bool?
    
    required init(json: JSON)
    {
        pseudo = json["pseudo"].stringValue //.xxxValue pour des getters non-optionnels
        mdp = json["mdp"].stringValue
        
        if let _nom = json["nom"].string //.string ou .bool pour des getters optionnels
        {
            nom = _nom
        }
        if let _prenom = json["prenom"].string
        {
            prenom = _prenom
        }
        if let _ville = json["ville"].string
        {
            ville = _ville
        }
        if let _estMobile = json["EstMobile"].bool
        {
            estMobile = _estMobile
        }
        if let _typ = json["Typ"].bool
        {
            typ = _typ
        }
        if let _divers = json["Divers"].string
        {
            divers = _divers
        }
        if let _dispo = json["Dispo"].bool
        {
            dispo = _dispo
        }
    }

    
    func toDict() -> [String : Any]
    {
        var str : [String : Any] = [
            "pseudo": pseudo,
            "mdp": mdp
        ]
        
        if let _nom = nom as String?
        {
            str["nom"] = _nom
        }
        if let _prenom = prenom as String?
        {
            str["prenom"] = _prenom
        }
        if let _ville = ville as String?
        {
            str["ville"] = _ville
        }
        if let _estMobile = estMobile as Bool?
        {
            str["EstMobile"] = _estMobile
        }
        if let _typ = typ as Bool?
        {
            str["Typ"] = _typ
        }
        if let _divers = divers as String?
        {
            str["Divers"] = _divers
        }
        if let _dispo = dispo as Bool?
        {
            str["Dispo"] = _dispo
        }
        
        return str
    }

}
