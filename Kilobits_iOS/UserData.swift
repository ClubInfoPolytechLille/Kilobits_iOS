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
    
    func toDict() -> [String : AnyObject]
    {
        let str : [String : AnyObject] = [
            "pseudo": "\"" + pseudo + "\"" as AnyObject,
            "nom": nom as AnyObject,
            "prenom": prenom as AnyObject,
            "mdp": "\"" + mdp + "\"" as AnyObject,
            "ville": ville as AnyObject,
            "estMobile": estMobile as AnyObject,
            "typ": typ as AnyObject,
            "divers": divers as AnyObject,
            "dispo": dispo as AnyObject
        ]
        
        return str
    }
    
    func toDict2() -> [String : AnyObject]
    {
        let str : [String : AnyObject] = [
            "pseudo": "\"" + pseudo + "\"" as AnyObject,
            "mdp": "\"" + mdp + "\"" as AnyObject
        ]
        
        return str
    }
}
