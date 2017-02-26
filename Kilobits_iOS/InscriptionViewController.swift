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
    @IBOutlet weak var city: UIPickerView!
    @IBOutlet weak var isMigrant: UISwitch!
    @IBOutlet weak var hasFreeTime: UISwitch!
    @IBOutlet weak var miscellaneous: UITextView!
    @IBOutlet weak var createAccount: UIButton!
    
    let cityData : [String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideKeyboardWithTouch()
        createAccount.isEnabled = false
        name.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        firstName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        identifier.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountAction(_ sender: UIButton)
    {
        
    }
    
    // MARK: UITextFieldDelegate
    //Quand l'utilisateur tape sur Done/Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if name.isFirstResponder
        {
            name.resignFirstResponder() //fait disparaître le clavier
            firstName.becomeFirstResponder()
        }
        else if firstName.isFirstResponder
        {
            firstName.resignFirstResponder()
            identifier.becomeFirstResponder()
        }
        else if identifier.isFirstResponder
        {
            identifier.resignFirstResponder()
            password.becomeFirstResponder()
        }
        else if password.isFirstResponder
        {
            password.resignFirstResponder()
            city.becomeFirstResponder()
        }
        else if city.isFirstResponder
        {
            city.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        createAccount.isEnabled = name.text != "" && firstName.text != "" && identifier.text != "" && password.text != ""
    }
    
    func textFieldDidChange(_ textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        createAccount.isEnabled = name.text != "" && firstName.text != "" && identifier.text != "" && password.text != ""
    }
    
    // MARK: UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return cityData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return cityData[row]
    }

    @IBAction func Cancel(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
}
