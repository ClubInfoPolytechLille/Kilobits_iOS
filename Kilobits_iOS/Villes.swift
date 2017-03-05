//
//  Villes.swift
//  Kilobits_iOS
//
//  Created by Marianne on 03/03/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Une structure de données pour représenter les villes.
class Villes
{
    // MARK: - Variables
    
    /// Un dictionnaire contenant les IDs et noms des villes.
    var villes = [Int : String]()
    
    
    
    // MARK: - Initialisation
    
    /// Initialisation des villes à partir d'un texte `JSON`.
    ///
    /// - Parameter json: Le `JSON` permettant de générer les villes.
    required init(json: JSON)
    {
        for i in 0..<json.count  //Pour chaque NSDictionary de l'Array
        {
            let ville = json[i]
            
            let id = ville["id"].intValue //.xxxValue pour des getters non-optionnels
            let name = ville["name"].stringValue
            
            villes[id] = name
        }
    }
    
    /// Initialisation des villes à partir de paramètres classiques.
    ///
    /// - Parameters:
    ///   - villes: Un dictionnaire contenant les IDs et noms des villes.
    required init(villes : [Int : String])
    {
        self.villes = villes
    }
    
    
    
    // MARK: - Getters
    
    /// Renvoie le nom de la ville dont l'ID est passé en paramètre.
    ///
    /// - Parameter id: ID de la ville
    /// - Returns: Le nom de la ville.
    func getName(id : Int) -> String
    {
        return villes[id]!
    }
    
    /// Renvoie les noms des villes.
    ///
    /// - Returns: Un array de `String` pour les noms des villes.
    func getAllNames() -> [String]
    {
        var names = [String]()
        
        for (_, name) in Array(villes).sorted(by: {$0.0 < $1.0})
        {
            names.append(name)
        }
        print(names)
        
        return names
    }
}

