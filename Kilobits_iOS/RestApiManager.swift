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
    static let sharedInstance = RestApiManager()
    let baseURL = "https://kilobits.clubinfo.frogeye.fr/"
    var user : UserData? //Un seul utilisateur pour toute l'appli
    
    // MARK: API Functions
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
    
    func createUser(user: UserData) {
        
    }
    
    func connectUser(user: UserData, completionHandler: @escaping (Bool) -> Void) {
        let route = baseURL + "user/connect"

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
                
                //newUser = UserData(json: JSON(dict))
                self.user = UserData(json: JSON(dict))
                
                SpeedLog.print("Utilisateur \(user.pseudo!) connecté.")
                completionHandler(true)
            })
    }
    
    func getTestRequest() {
        let route = "https://jsonplaceholder.typicode.com/posts/1"
        
        Alamofire.request(route, method: .get)
            .responseJSON(completionHandler: { response in
                //handle JSON
                SpeedLog.print("JSON traitement")
                guard let json = response.result.value as? [String: Any] else {
                    SpeedLog.print("didn't get posts object as JSON from API")
                    SpeedLog.print("Error : \(response.result.error)")
                    return
                }
                SpeedLog.print(json)
            })
    }
    
    func postTestRequest(post: [String : Any]) {
        let route = "https://jsonplaceholder.typicode.com/posts"
        
         Alamofire.request(route, method: .post, parameters: post, encoding: JSONEncoding.default)
            .responseJSON(completionHandler: { response in
                //handle JSON
                SpeedLog.print("JSON traitement")
         
                guard response.result.error == nil else
                {
                    SpeedLog.print("error calling POST on /posts")
                    SpeedLog.print(response.result.error!)
                    return
                }
         
                guard let json = response.result.value as? [String: Any] else {
                    SpeedLog.print("didn't get posts object as JSON from API")
                    SpeedLog.print("Error : \(response.result.error)")
                    return
                }
         
                SpeedLog.print(json)
         
                guard let title = json["title"] as? String else {
                    SpeedLog.print("Could not get todo title from JSON")
                    return
                }
         
                SpeedLog.print("The title is " + title)
            })
        
    }
}
