//
//  InscriptionViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 01/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import UIKit

class InscriptionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var identifier: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var isMobile: UISwitch!
    @IBOutlet weak var cityNearby: UIPickerView!
    @IBOutlet weak var language: UIPickerView!
    @IBOutlet weak var isMigrant: UISwitch!
    @IBOutlet weak var createAccount: UIButton!
    
    let cityData : [String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideKeyboardWithTouch()
        createAccount.enabled = false
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountAction(sender: UIButton)
    {
        /*let URL: NSURL = NSURL(string: "https://2016.ninfo.frogeye.fr/v1/")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:URL)
        request.HTTPMethod = "POST"
        let bodyData = "Pseudo=" + "Poupou"
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            let mdp = NSString(data: data!, encoding: NSUTF8StringEncoding) //mdp
            print(mdp)
            
            /*if mdp == self.mdpTextField.text!
             {*/
            self.performSegueWithIdentifier("goToMenuMigrantFromConnexion", sender: self)
            //}
        })
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        
        task.resume()*/
    }
    
    // MARK: UITextFieldDelegate
    //Quand l'utilisateur tape sur Done/Return
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if name.isFirstResponder()
        {
            name.resignFirstResponder() //fait disparaître le clavier
            firstName.becomeFirstResponder()
        }
        else if firstName.isFirstResponder()
        {
            firstName.resignFirstResponder()
            identifier.becomeFirstResponder()
        }
        else if identifier.isFirstResponder()
        {
            identifier.resignFirstResponder()
            password.becomeFirstResponder()
        }
        else if password.isFirstResponder()
        {
            password.resignFirstResponder()
            cityNearby.becomeFirstResponder()
        }
        else if cityNearby.isFirstResponder()
        {
            cityNearby.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        createAccount.enabled = name.text != "" && firstName.text != "" && password.text != ""
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        createAccount.enabled = name.text != "" && firstName.text != "" && password.text != ""
    }
    
    // MARK: UIPickerViewDelegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return cityData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return cityData[row]
    }

    @IBAction func Cancel(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}