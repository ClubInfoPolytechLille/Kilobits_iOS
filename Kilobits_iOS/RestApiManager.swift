//
//  RestApiManager.swift
//  Kilobits_iOS
//
//  Created by Marianne on 19/02/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import SpeedLog

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    
    // MARK: - Variables
    static let sharedInstance = RestApiManager()
    let baseURL = "https://kilobits.clubinfo.frogeye.fr/"
    var user : UserData? //Un seul utilisateur pour toute l'appli
    
    // MARK: - API GET Functions
    func getAllUsers(completionHandler: @escaping ([UserData]) -> Void) {
        var users = [UserData]()
        let route = baseURL + "user"
        
        Alamofire.request(route, method: .get)
            .responseJSON(completionHandler: { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    SpeedLog.print("error calling GET on /user")
                    SpeedLog.print(response.result.error!)
                    return
                }
                
                guard let json = response.result.value as? NSArray else {
                    SpeedLog.print("didn't get user object as JSON from API")
                    SpeedLog.print("Error : \(response.result.error)")
                    return
                }
                
                for user in json //Pour chaque NSDictionary de l'Array
                {
                    users.append(UserData(json: JSON(user)))
                }
                
                completionHandler(users)
            })
    }
    
    func getAllCities(completionHandler: @escaping (Villes) -> Void) {
        var cities : Villes = Villes(villes: [:])
        let route = baseURL + "villes"
        
        Alamofire.request(route, method: .get)
            .responseJSON(completionHandler: { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    SpeedLog.print("error calling GET on /villes")
                    SpeedLog.print(response.result.error!)
                    return
                }
                
                guard let json = response.result.value as? NSArray else {
                    SpeedLog.print("didn't get ville object as JSON from API")
                    SpeedLog.print("Error : \(response.result.error)")
                    return
                }

                cities = Villes(json: JSON(json))
                completionHandler(cities)
            })
    }
    
    func getAllLanguages(completionHandler: @escaping ([String]) -> Void) {
        var langues = [String]()
        let route = baseURL + "langues"
        
        Alamofire.request(route, method: .get)
            .responseJSON(completionHandler: { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    SpeedLog.print("error calling GET on /langues")
                    SpeedLog.print(response.result.error!)
                    return
                }
                
                guard let json = response.result.value as? NSArray else {
                    SpeedLog.print("didn't get language object as JSON from API")
                    SpeedLog.print("Error : \(response.result.error)")
                    return
                }
                
                for langueDict in json //Pour chaque NSDictionary de l'Array
                {
                    let langue = JSON(langueDict)
                    langues.append(langue["langue"].stringValue)
                }
                
                completionHandler(langues)
            })
    }
    
    // MARK: - API POST Functions
    //La requête ne renvoie rien -> pour savoir si ça a marché, on essaye de se connecter après. Sinon on montre une alerte. On peut aussi vérifier avant d'envoyer la requête que l'utilisateur n'existe pas.
    func createUser(user: UserData, completionHandler: @escaping (Int) -> Void) {
        let route = baseURL + "user"
 
        //On vérifie que l'utilisateur n'existe pas déjà
        RestApiManager.sharedInstance.getAllUsers(completionHandler: { users in
            for us in users
            {
                guard us.pseudo != user.pseudo else
                {
                    SpeedLog.print("Ce pseudo est déjà utilisé.")
                    completionHandler(0)
                    return
                }
            }
            
            Alamofire.request(route, method: .post, parameters: user.toDict(), encoding: JSONEncoding.default)
                .response(completionHandler: { response in
                    
                    //On essaye de se connecter
                    RestApiManager.sharedInstance.connectUser(user: user, completionHandler: { success in
                        if success
                        {
                            SpeedLog.print("Utilisateur \(user.pseudo!) créé.")
                            completionHandler(1)
                        }
                        else //L'utilisateur n'a pas été créé
                        {
                            SpeedLog.print("Il manque des champs nécessaires pour créer l'utilisateur.")
                            completionHandler(-1)
                        }
                        
                    })
                })
            
        })
    }
    
    func connectUser(user: UserData, completionHandler: @escaping (Bool) -> Void) {
        let route = baseURL + "user/connect"
        user.prenom = "bli"
        user.nom = "E"
        print(user.toDict())
        Alamofire.request(route, method: .post, parameters: user.toDict(), encoding: JSONEncoding.default)
            .responseJSON(completionHandler: { response in
                guard response.result.error == nil else
                {
                    if response.response!.statusCode == 404
                    {
                        SpeedLog.print("L'utilisateur ou le mot de passe est incorrect.")
                        completionHandler(false)
                    }
                    else
                    {
                        SpeedLog.print("error calling POST on /user/connect")
                        SpeedLog.print(response.result.error!)
                        SpeedLog.print("Code erreur \(response.response!.statusCode)")
                    }
                    return
                }
                guard let dict = response.result.value as? [String : Any] else {
                    SpeedLog.print("didn't get user object as JSON from API")
                    SpeedLog.print("Error : \(response.result.error)")
                    return
                }
                
                self.user = UserData(json: JSON(dict))
                
                SpeedLog.print("Utilisateur \(user.pseudo!) connecté.")
                completionHandler(true)
            })
    }
    
    
}
