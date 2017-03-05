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
    // MARK: - IBOutlets
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
    
    // MARK: - Initialisation
    //TODO: Trouver le moyen de retirer la ligne vide mise par défaut dans la textview
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        hideKeyboardWithTouch()
        createAccount.isEnabled = false
        miscellaneous.enablesReturnKeyAutomatically = false //On peut créer un compte sans forcément de texte dans ce champs
        
        //Activation/Désactivation du bouton 'create account'
        name.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        firstName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        identifier.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        //Rend la textview miscellaneous visible lors de son édition
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextFieldDelegate
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
            miscellaneous.becomeFirstResponder()
        }
        else if miscellaneous.isFirstResponder
        {
            miscellaneous.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        createAccount.isEnabled = name.text != "" && firstName.text != "" && identifier.text != "" && password.text != ""
    }
    
    //À chaque lettre écrite, vérifie si on peut créer un utilisateur ou pas
    func textFieldDidChange(_ textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        createAccount.isEnabled = name.text != "" && firstName.text != "" && identifier.text != "" && password.text != ""
    }
    
    //Scroll the view up when miscellaneous is not visible (hidden under the keyboard)
    func keyboardWillShow(notification: NSNotification) {
        
        if(miscellaneous.isFirstResponder)
        {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
        
    }
    
    //Scroll the view down when it was scrolled up and the keyboard should disappear
    func keyboardWillHide(notification: NSNotification) {
        if(miscellaneous.isFirstResponder)
        {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
        }
    }
    
    // MARK: - UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return RestApiManager.sharedInstance.cityData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return RestApiManager.sharedInstance.cityData[row].1
    }
    
    // MARK: - IBActions

    @IBAction func Cancel(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountAction(_ sender: UIButton)
    {
        //let user = UserData(json: ["pseudo":"userTest3", "nom":"TestNom", "prenom":"TestPrenom", "ville":"Lille","mdp":"unicorn", "estMobile":false, "typ":false, "dispo":true]) //Pour que le debug soit plus facile
        let ville = RestApiManager.sharedInstance.cityData[city.selectedRow(inComponent: 0)].0
        let divers = miscellaneous.text
        let user = UserData(json: ["pseudo":identifier.text!, "nom":name.text!, "prenom":firstName.text!, "mdp":password.text!, "ville":ville, "estMobile":isMobile.isOn, "typ":!isMigrant.isOn, "dispo":hasFreeTime.isOn]) //Vraie version
        if !divers!.isEmpty
        {
            user.divers = divers
        }
        
        RestApiManager.sharedInstance.createUser(user: user, completionHandler: { success in
            if success == 1
            {
                self.performSegue(withIdentifier: "goToMenuUserFromInscription", sender: self)
            }
            else if success == 0
            {
                //LocalizedStrings
                let titre = "alerte_erreur_titre".localized(table: "Common")
                let contenu = "alerte_utilisateur_existant_contenu".localized(table: "InscriptionViewController")
                let action = "alerte_action_OK".localized(table: "Common")
                
                //Alerte
                let alerte = UIAlertController(title: titre, message: contenu, preferredStyle: UIAlertControllerStyle.alert)
                alerte.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: nil))
                self.present(alerte, animated: true, completion: nil)
            }
            else
            {
                //LocalizedStrings
                let titre = "alerte_erreur_titre".localized(table: "Common")
                let contenu = "alerte_utilisateur_incomplet_contenu".localized(table: "InscriptionViewController")
                let action = "alerte_action_OK".localized(table: "Common")
                
                //Alerte
                let alerte = UIAlertController(title: titre, message: contenu, preferredStyle: UIAlertControllerStyle.alert)
                alerte.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: nil))
                self.present(alerte, animated: true, completion: nil)
            }
        })
    }

}
