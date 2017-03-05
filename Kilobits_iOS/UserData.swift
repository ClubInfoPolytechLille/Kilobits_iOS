//
//  UserData.swift
//  Kilobits_iOS
//
//  Created by Marianne on 19/02/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Une classe contenant les informations de l'utilisateur et permettant le passage bilatéral `JSON`/`UserData`.
class UserData
{
    // MARK: - Variables
    
    /// ID (généré automatiquement à la création) de l'utilisateur.
    var id: Int?
    
    /// Pseudonyme de l'utilisateur.
    var pseudo: String!
    
    /// Nom de l'utilisateur.
    var nom: String?
    
    /// Prénom de l'utilisateur.
    var prenom: String?
    
    /// Mot de passe de l'utilisateur.
    var mdp: String!
    
    /// ID de la ville la plus proche de l'utilisateur.
    var ville: Int?
    
    /// `True` si l'utilisateur a les moyens de se déplacer, `false` sinon.
    var estMobile: Bool?
    
    /// `True` si l'utilisateur est un aidant, `false` si c'est un migrant.
    var typ: Bool?
    
    /// Informations complémentaires précisées par l'utilisateur.
    var divers: String?
    
    /// `True` si l'utilisateur a du temps libre à contribuer aux événements, `false` sinon.
    var dispo: Bool?
    
    
    
    // MARK: - Initialisation
    
    /// Initialisation de l'utilisateur à partir d'un texte `JSON`.
    ///
    /// - Parameter json: Le `JSON` permettant de générer l'utilisateur.
    required init(json: JSON)
    {
        pseudo = json["pseudo"].stringValue //.xxxValue pour des getters non-optionnels
        mdp = json["mdp"].stringValue
        
        if let _id = json["id"].int //.string ou .bool pour des getters optionnels
        {
            id = _id
        }
        if let _nom = json["nom"].string
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
    
    /// Initialisation de l'utilisateur à partir de paramètres classiques.
    ///
    /// - Parameters:
    ///   - pseudo: Pseudonyme de l'utilisateur.
    ///   - mdp: Mot de passe de l'utilisateur.
    ///   - id: ID de l'utilisateur.
    ///   - nom: Nom de l'utilisateur.
    ///   - prenom: Prénom de l'utilisateur.
    ///   - ville: ID de la ville la plus proche de l'utilisateur.
    ///   - estMobile: `True` si l'utilisateur a les moyens de se déplacer, `false` sinon.
    ///   - typ: `True` si l'utilisateur est un aidant, `false` si c'est un migrant.
    ///   - dispo: `True` si l'utilisateur a du temps libre à contribuer aux événements, `false` sinon.
    ///   - divers: Informations complémentaires précisées par l'utilisateur.
    required init(pseudo: String, mdp: String, id: Int?, nom: String?, prenom: String?, ville: Int?, estMobile: Bool?, typ: Bool?, dispo: Bool?, divers: String?)
    {
        self.pseudo = pseudo
        self.mdp = mdp
        self.id = id
        self.nom = nom
        self.prenom = prenom
        self.ville = ville
        self.estMobile = estMobile
        self.typ = typ
        self.dispo = dispo
        self.divers = divers
    }

    
    
    // MARK: - Getters
    
    /// Transforme l'utilisateur en dictionnaire au format JSON.
    ///
    /// - Returns: Un dictionnaire JSON `String` : `Any` de l'utilisateur.
    func toDict() -> [String : Any]
    {
        var str : [String : Any] = [
            "pseudo": pseudo,
            "mdp": mdp
        ]
        
        if let _id = id as Int?
        {
            str["id"] = _id
        }
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
