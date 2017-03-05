//
//  ProfileViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 02/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate
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
    @IBOutlet weak var deleteAccount: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Initialisation
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //get user info and load it all
        name.text = RestApiManager.sharedInstance.user!.nom
        firstName.text = RestApiManager.sharedInstance.user!.prenom
        identifier.text = RestApiManager.sharedInstance.user!.pseudo
        password.text = RestApiManager.sharedInstance.user!.mdp
        isMobile.setOn(RestApiManager.sharedInstance.user!.estMobile!, animated: false)
        city.selectRow(RestApiManager.sharedInstance.user!.ville! - 1, inComponent: 0, animated: false)
        isMigrant.setOn(!RestApiManager.sharedInstance.user!.typ!, animated: false)
        hasFreeTime.setOn(RestApiManager.sharedInstance.user!.dispo!, animated: false)
        if let divers = RestApiManager.sharedInstance.user!.divers
        {
            miscellaneous.insertText(divers)
        }
        
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
    
    // MARK: - IBActions
    @IBAction func Cancel(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "goToMenuUserFromProfile", sender: self)
    }
    
    @IBAction func Save(_ sender: UIBarButtonItem)
    {
        //TODO: Send request to update user
        let user : UserData = UserData(pseudo: identifier.text!, mdp: password.text!, id: RestApiManager.sharedInstance.user!.id!, nom: name.text!, prenom: firstName.text!, ville: RestApiManager.sharedInstance.cityData[city.selectedRow(inComponent: 0)].0, estMobile: isMobile.isOn, typ: !isMigrant.isOn, dispo: hasFreeTime.isOn, divers: miscellaneous.text)
        
        print(user.toDict())
        /*RestApiManager.sharedInstance.updateUser(user: user, completionHandler: { success in
            if success == 1
            {
                RestApiManager.sharedInstance.user = user
                
                self.performSegue(withIdentifier: "goToMenuMigrantFromProfile", sender: self)
            }
            else if success == 0 //TODO; Delete after update if needed
            {
                //LocalizedStrings
                let titre = "alerte_erreur_titre".localized(table: "Common")
                let contenu = "alerte_utilisateur_existant_contenu".localized(table: "ProfileViewController")
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
                let contenu = "alerte_utilisateur_incomplet_contenu".localized(table: "ProfileViewController")
                let action = "alerte_action_OK".localized(table: "Common")
                
                //Alerte
                let alerte = UIAlertController(title: titre, message: contenu, preferredStyle: UIAlertControllerStyle.alert)
                alerte.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: nil))
                self.present(alerte, animated: true, completion: nil)
            }
        }*/
    }
    
    @IBAction func CloseAccount(_ sender: UIButton)
    {
        //TODO: Send request to delete user
        let message = "alerte_delete_account_contenu".localized(table: "ProfileViewController")
        let confirmAlertCtrl = UIAlertController(title: "alerte_delete_account_titre".localized(table: "ProfileViewController"), message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "alerte_delete_account_confirm_action".localized(table: "ProfileViewController"), style: .destructive) { _ in
            //Send request
            print("delete account")
            self.navigationController!.navigationBar.isHidden = true
            RestApiManager.sharedInstance.user = nil
            self.performSegue(withIdentifier: "goToMenuFromProfile", sender: self)
        }
        confirmAlertCtrl.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "alerte_action_Cancel".localized(table: "Common"), style: .cancel, handler: nil)
        confirmAlertCtrl.addAction(cancelAction)
        
        present(confirmAlertCtrl, animated: true, completion: nil)
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
        saveButton.isEnabled = name.text != "" && firstName.text != "" && identifier.text != "" && password.text != ""
    }
    
    //À chaque lettre écrite, vérifie si on peut créer un utilisateur ou pas
    func textFieldDidChange(_ textField: UITextField)
    {
        // Ne pas autoriser l'utilisateur à continuer s'il n'a pas rentré un nom et un mdp
        saveButton.isEnabled = name.text != "" && firstName.text != "" && identifier.text != "" && password.text != ""
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
}


