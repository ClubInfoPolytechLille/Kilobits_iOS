//
//  EvenementData.swift
//  Kilobits_iOS
//
//  Created by Marianne on 04/03/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Une classe contenant les informations des événements et permettant le passage bilatéral `JSON`/`EvenementData`.
class EvenementData
{
    // MARK: - Variables
    
    /// ID (généré automatiquement à la création) de l'événement.
    var id: Int?
    
    /// Lieu de l'événement.
    var lieu: String!
    
    /// Date de l'événement.
    var dat: Date!
    
    /// Description de l'événement.
    var description: String!
    
    
    
    // MARK: - Initialisation
    
    /// Initialisation de l'événement à partir d'un texte `JSON`.
    ///
    /// - Parameter json: Le `JSON` permettant de générer l'événement.
    required init(json: JSON)
    {
        lieu = json["lieu"].stringValue
        dat = json["dat"].dateValue
        description = json["description"].stringValue
        
        if let _id = json["id"].int
        {
            id = _id
        }
    }
    
    /// Initialisation de l'événement à partir de paramètres classiques.
    ///
    /// - Parameters:
    ///   - lieu: Lieu de l'événement.
    ///   - dat: Date de l'événement.
    ///   - description: Description de l'événement.
    ///   - id: ID de l'événement.
    required init(lieu: String, dat: Date, description: String, id: Int?)
    {
        self.id = id
        self.lieu = lieu
        self.dat = dat
        self.description = description
    }
    
    
    
    // MARK: - Getters
    
    /// Transforme l'événement en dictionnaire au format JSON.
    ///
    /// - Returns: Un dictionnaire JSON `String` : `Any` de l'événement.
    func toDict() -> [String : Any]
    {
        var str : [String : Any] = [
            "lieu": lieu,
            "dat": dat,
            "description": description
        ]
        
        if let _id = id as Int?
        {
            str["id"] = _id
        }
        
        return str
    }
}
