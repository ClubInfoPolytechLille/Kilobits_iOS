//
//  ConnexionViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 01/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import UIKit

class ConnexionViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var mdpTextField: UITextField!
    @IBOutlet weak var boutonConnexion: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideKeyboardWithTouch()
        boutonConnexion.enabled = false
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seConnecter(sender: UIButton)
    {
        //Données
        _ = ["pseudo": "Poulou", "mdp": "testmdp"]
        
        //String sql = "SELECT pseudo, Typ FROM utilisateur WHERE pseudo = ? AND mdp = ? ;";
        
        //Requête
        let URL: NSURL = NSURL(string: "https://2016.ninfo.frogeye.fr/v1/langues")! // /users/connect
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:URL)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET" //POST
        //request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(dic, options: [])

        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            guard let res = NSString(data: data!, encoding: NSUTF8StringEncoding) where error == nil else
            {
                print("error: \(error)")
                return
            }
            print("Data : " + (res as String))
            print("Response : " + (response?.description)!)
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary {
                    /*let pseudo = json["pseudo"] as? String
                    print("Pseudo : \(pseudo)")
                    let estMigrant = json["Typ"] as? Bool
                    print("EstMigrant : \(estMigrant)")*/
                    let langue = json["langue"] as? String
                    print("Langue : \(langue)")
                } else {
                    let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)    // No error thrown, but not NSDictionary
                    print("Error could not parse JSON: \(jsonStr)")
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = String(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
            
        })
        
        self.performSegueWithIdentifier("goToMenuMigrantFromConnexion", sender: self)
        task.resume()
    }
 
    // MARK: UITextFieldDelegate
    //Quand l'utilisateur tape sur Done/Return
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if nomTextField.isFirstResponder()
        {
            nomTextField.resignFirstResponder() //fait disparaître le clavier
            mdpTextField.becomeFirstResponder()
        }
        else if mdpTextField.isFirstResponder()
        {
            mdpTextField.resignFirstResponder()
            seConnecter(boutonConnexion)
        }
        
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        boutonConnexion.enabled = nomTextField.text != "" && mdpTextField.text != ""
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        boutonConnexion.enabled = nomTextField.text != "" && mdpTextField.text != ""
    }

    @IBAction func Cancel(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}