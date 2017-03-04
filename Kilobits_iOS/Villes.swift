//
//  Villes.swift
//  Kilobits_iOS
//
//  Created by Marianne on 03/03/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import SwiftyJSON

class Villes
{
    // MARK: - Variables
    var villes = [Int : String]()
    
    // MARK: - Initialisation
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
    
    required init(villes : [Int : String])
    {
        self.villes = villes
    }
    
    // MARK: - Getters
    func getName(id : Int) -> String
    {
        return villes[id]!
    }
    
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

