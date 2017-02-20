//
//  RestApiManager.swift
//  Kilobits_iOS
//
//  Created by Marianne on 19/02/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    let baseURL = "https://kilobits.clubinfo.frogeye.fr/"
    
    // MARK: API Functions
    func getAllUsers(onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL + "user"
        makeHTTPGetRequest(path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func createUser(user: UserData, onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL + "user"
        
        makeHTTPPostRequest(path: route, body: user.toDict(), onCompletion:
            { json, err in onCompletion(json as JSON)})
    }
    
    func connectUser(user: UserData, onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL + "user/connect"
        print("User to dict : ")
        print(user.toDict2())
        
        makeHTTPPostRequest(path: route, body: user.toDict2(), onCompletion:
            { json, err in onCompletion(json as JSON)
        })
        
    }
    
    // MARK: Perform a GET Request
    private func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            print("response : ", response as Any)
            
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error as NSError?)
            } else {
                onCompletion(JSON.null, error as NSError?)
            }
        })
        task.resume()
    }
    
    // MARK: Perform a POST Request
    private func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        // Set the method to POST
        request.httpMethod = "POST"
        
        do {
            // Set the POST body for the request
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = jsonBody
            let session = URLSession.shared
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                print("response : ", response as Any)
                
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                    print("PAS D'ERREUR sur la requête POST")
                } else {
                    print("ERREUR sur la requête POST 2")
                    onCompletion(JSON.null, error as NSError?)
                }
            })
            task.resume()
        } catch {
            // Create your personal error
            print("ERREUR sur la requête POST")
            onCompletion(JSON.null, nil)
        }
    }
}
