//
//  ConnexionViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 01/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import UIKit
import SpeedLog

class ConnexionViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate
{
    // MARK: - IBOutlets
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var mdpTextField: UITextField!
    @IBOutlet weak var boutonConnexion: UIButton!
    
    // MARK: - Initialisation
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideKeyboardWithTouch()
        boutonConnexion.isEnabled = false
        nomTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        mdpTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func seConnecter(_ sender: UIButton)
    {
        //let user = UserData(json: ["pseudo":"badetitou", "mdp":"unicorn"]) //Pour que le debug soit plus facile
        let user = UserData(json: ["pseudo":nomTextField.text!, "mdp":mdpTextField.text!]) //Vraie version
        
        RestApiManager.sharedInstance.connectUser(user: user, completionHandler: { success in
            if success
            {
                self.performSegue(withIdentifier: "goToMenuUserFromConnexion", sender: self)
            }
            else
            {
                //LocalizedStrings
                let titre = "alerte_erreur_titre".localized(table: "Common")
                let contenu = "alerte_404_contenu".localized(table: "ConnexionViewController")
                let action = "alerte_action_OK".localized(table: "Common")
                
                //Alerte
                let alerte = UIAlertController(title: titre, message: contenu, preferredStyle: UIAlertControllerStyle.alert)
                alerte.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: nil))
                self.present(alerte, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
 
    // MARK: - UITextFieldDelegate
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
    
    func textFieldDidChange(_ textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        boutonConnexion.isEnabled = nomTextField.text != "" && mdpTextField.text != ""
    }
}
