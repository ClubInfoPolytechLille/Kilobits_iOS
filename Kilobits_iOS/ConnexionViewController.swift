//
//  ConnexionViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 01/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

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
        boutonConnexion.isEnabled = false
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seConnecter(_ sender: UIButton)
    {
        //self.performSegue(withIdentifier: "goToMenuMigrantFromConnexion", sender: self)
        
        //GET Alamofire -> Fonctionne
        //RestApiManager.sharedInstance.getTestRequest()
        
        //GET Alamofire Kilobits -> Fonctionne
        /*var users = [UserData]()
        RestApiManager.sharedInstance.getAllUsers(completionHandler: { us in
            users = us
            
            for user in users
            {
                print("pseudo : ", user.pseudo)
            }
        })*/
        
        
        //POST Alamofire -> Fonctionne !!!
        //let newPost: [String: Any] = ["title":"foo", "body":"bar", "userId":10]
        //RestApiManager.sharedInstance.postTestRequest(post: newPost)
        
        //POST Alamofire Kilobits -> Ne marche pas, on recoit null (pb serveur)
        /*var user = UserData(json: ["pseudo":"badetitou", "mdp":"unicorn"])
        RestApiManager.sharedInstance.connectUser(user: user, completionHandler: { us in
            user = us
            
            print("pseudo : ", user.pseudo)
            print("typ : ", user.typ as Any)
        })*/
    }
 
    // MARK: UITextFieldDelegate
    //Quand l'utilisateur tape sur Done/Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if nomTextField.isFirstResponder
        {
            nomTextField.resignFirstResponder() //fait disparaître le clavier
            mdpTextField.becomeFirstResponder()
        }
        else if mdpTextField.isFirstResponder
        {
            mdpTextField.resignFirstResponder()
            seConnecter(boutonConnexion)
        }
        
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        boutonConnexion.isEnabled = nomTextField.text != "" && mdpTextField.text != ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        boutonConnexion.isEnabled = nomTextField.text != "" && mdpTextField.text != ""
    }

    @IBAction func Cancel(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
}
