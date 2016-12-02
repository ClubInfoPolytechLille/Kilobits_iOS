//
//  ConnexionViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 01/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import UIKit

class ConnexionViewController: UIViewController, UITextFieldDelegate
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

}