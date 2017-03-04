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
    // MARK: - Variables
    var pseudo: String!
    var nom: String?
    var prenom: String?
    var mdp: String!
    var ville: Int?
    var estMobile: Bool?
    var typ: Bool?
    var divers: String?
    var dispo: Bool?
    
    // MARK: - Initialisation
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
        if let _ville = json["ville"].int
        {
            ville = _ville
        }
        if let _estMobile = json["estMobile"].bool
        {
            estMobile = _estMobile
        }
        if let _typ = json["typ"].bool
        {
            typ = _typ
        }
        if let _divers = json["divers"].string
        {
            divers = _divers
        }
        if let _dispo = json["dispo"].bool
        {
            dispo = _dispo
        }
    }

    // MARK: - Getters
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
        if let _ville = ville as Int?
        {
            str["ville"] = _ville
        }
        if let _estMobile = estMobile as Bool?
        {
            str["estMobile"] = _estMobile
        }
        if let _typ = typ as Bool?
        {
            str["typ"] = _typ
        }
        if let _divers = divers as String?
        {
            str["divers"] = _divers
        }
        if let _dispo = dispo as Bool?
        {
            str["dispo"] = _dispo
        }
        
        return str
    }

}
