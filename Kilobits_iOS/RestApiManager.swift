//
//  RestApiManager.swift
//  Kilobits_iOS
//
//  Created by Marianne on 19/02/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    let baseURL = "https://kilobits.clubinfo.frogeye.fr/"
    
    // MARK: API Functions
    func getAllUsers(completionHandler: @escaping ([UserData]) -> Void) {
        var users = [UserData]()
        let route = baseURL + "user"
        
        Alamofire.request(route, method: .get)
            .responseJSON(completionHandler: { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /user")
                    print(response.result.error!)
                    return
                }
                
                guard let json = response.result.value as? NSArray else {
                    print("didn't get user object as JSON from API")
                    print("Error : \(response.result.error)")
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
    
    func connectUser(user: UserData, completionHandler: @escaping (UserData) -> Void) {
        let route = baseURL + "user/connect"
        let newUser = user
        
        print("user.toDict : ", user.toDict())

        Alamofire.request(route, method: .post, parameters: user.toDict(), encoding: JSONEncoding.default)
            .responseJSON(completionHandler: { response in
                print("JSON traitement")
                
                guard response.result.error == nil else
                {
                    print("error calling POST on /user/connect")
                    print(response.result.error!)
                    return
                }
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get user object as JSON from API")
                    print("Error : \(response.result.error)")
                    return
                }
                
                print("JSON : ", json) //Tests
                
                guard let pseudo = json["pseudo"] as? String else {
                    print("Could not get user pseudo from JSON")
                    return
                }
                guard let typ = json["typ"] as? Bool else {
                    print("Could not get user typ from JSON")
                    return
                }
                
                print("The pseudo is " + pseudo + " and the typ is " + typ.description)
                
                newUser.typ = typ
                completionHandler(newUser)
            })
    }
    
    func getTestRequest() {
        let route = "https://jsonplaceholder.typicode.com/posts/1"
        
        Alamofire.request(route, method: .get)
            .responseJSON(completionHandler: { response in
                //handle JSON
                print("JSON traitement")
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get posts object as JSON from API")
                    print("Error : \(response.result.error)")
                    return
                }
                print(json)
            })
    }
    
    func postTestRequest(post: [String : Any]) {
        let route = "https://jsonplaceholder.typicode.com/posts"
        
         Alamofire.request(route, method: .post, parameters: post, encoding: JSONEncoding.default)
            .responseJSON(completionHandler: { response in
                //handle JSON
                print("JSON traitement")
         
                guard response.result.error == nil else
                {
                    print("error calling POST on /posts")
                    print(response.result.error!)
                    return
                }
         
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get posts object as JSON from API")
                    print("Error : \(response.result.error)")
                    return
                }
         
                print(json)
         
                guard let title = json["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
         
                print("The title is " + title)
            })
        
    }
}
