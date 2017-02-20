//
//  ConnexionViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 01/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import UIKit
import SwiftyJSON

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
        //Requete GET fonctionne, mais pas la POST pour le moment, on recupere null
        /*RestApiManager.sharedInstance.getAllUsers { (json: JSON) in
            if let users = json.array
            {
                for data in users
                {
                    let user = UserData(json: data)
                    print(user.pseudo)
                    self.performSegue(withIdentifier: "goToMenuMigrantFromConnexion", sender: self)
                }
            }
        }*/
        /*let user = UserData(json: ["pseudo":"badetitou", "mdp":"unicorn"])
        RestApiManager.sharedInstance.connectUser(user: user, onCompletion: { (json: JSON) in
            if let _pseudo = json["pseudo"].string
            {
                if let _typ = json["typ"].bool
                {
                    //Peut se connecter, même utilisateur
                    if user.pseudo == _pseudo
                    {
                        user.typ = _typ
                        print(user)
                        self.performSegue(withIdentifier: "goToMenuMigrantFromConnexion", sender: self)
                    }
                    else
                    {
                        print("ERREUR : Le pseudo de l'utilisateur voulan se connecter (" + user.pseudo + ") est différent de celui renvoyé par la base de données (" + _pseudo + ").")
                    }
                }
                else
                {
                    print(json["typ"].error as Any)
                    print(json)
                }
            }
            else
            {
                print(json["pseudo"].error as Any)
                print(json)
            }
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
