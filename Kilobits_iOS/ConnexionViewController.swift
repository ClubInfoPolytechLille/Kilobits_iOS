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
        let URL: NSURL = NSURL(string: "https://2016.ninfo.frogeye.fr/v1/")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:URL)
        request.HTTPMethod = "POST"
        let bodyData = "Pseudo=" + "Poupou"
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding)) //mdp
        })
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        
        task.resume()
        
        //performSegueWithIdentifier("goToMenuMigrantFromConnexion", sender: self)
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