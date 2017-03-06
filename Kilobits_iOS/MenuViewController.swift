//
//  ViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 01/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import UIKit
import SpeedLog

class MenuViewController: UIViewController
{
    // MARK: - IBOutlets
    /// Bouton pour changer la langue. Composé d'un drapeau et du nom de la langue.
    @IBOutlet var boutonLangues: UIButton!
    
    
    
    // MARK: - Initialisation
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //Charger les langues disponibles
        chargerLangues()
        
        //Load cities data from bdd
        RestApiManager.sharedInstance.getAllCities(completionHandler: { cities in
            RestApiManager.sharedInstance.cityData = Array(cities.villes).sorted(by: {$0.0 < $1.0})
        })
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let codeLangue : String = (UserDefaults.standard.object(forKey: "AppleLanguages") as! [String])[0]
        self.boutonLangues.setImage(UIImage(named: "Drapeau_" + codeLangue), for: UIControlState.normal)
        
        //Pour dans le cas où aucun langage n'a pu être chargé et on prend celui du téléphone
        boutonLangues.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        boutonLangues.setTitle(Locale.current.localizedString(forLanguageCode: Locale.current.languageCode!)!, for: UIControlState.disabled)
        boutonLangues.setImage(UIImage(named: "Drapeau_" + Locale.current.languageCode!), for: UIControlState.disabled)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "goToListeEvenements":
            guard let navController = segue.destination as? UINavigationController else {
                fatalError("Unexpected navigation destination: \(segue.destination)")
            }
            
            guard let viewController = navController.viewControllers.first! as? ListeEvenementsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
        
            viewController.comingFrom = "Menu"
        
        default: break
        }
    }
    
    /// Charge la liste des langues disponibles pour l'application récupérées par une requête à la BDD.
    func chargerLangues()
    {
        //On vérifie que l'utilisateur n'existe pas déjà
        RestApiManager.sharedInstance.getAllLanguages(completionHandler: { langues in
            
            if langues.isEmpty
            {
                //Griser le bouton langues et le mettre à jour avec la langue du système
                self.boutonLangues.isEnabled = false
                
                //LocalizedStrings
                let titre = "alerte_erreur_titre".localized(table: "Common")
                let contenu = "alerte_aucune_langue_contenu".localized(table: "MenuViewController")
                let action = "alerte_action_OK".localized(table: "Common")
                
                //Alerte
                let alerte = UIAlertController(title: titre, message: contenu, preferredStyle: UIAlertControllerStyle.alert)
                alerte.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: nil))
                self.present(alerte, animated: true, completion: nil)
            }
            
            RestApiManager.sharedInstance.langues = langues
        })
    }
    
    
    
    // MARK: - Utility Functions

    /// Affiche une alerte de confirmation pour le changement de langue à l'utilisateur. 
    ///
    /// S'il confirme, modifie la langue de l'application et ferme celle-ci.
    ///
    /// - Parameter langCode: Le code de la nouvelle langue (en, fr, ...).
    private func changeToLanguage(_ langCode: String) {
        if Bundle.main.preferredLocalizations.first != langCode {
            let message = "alerte_changer_langue_contenu".localized(table: "MenuViewController")
            let confirmAlertCtrl = UIAlertController(title: "alerte_changer_langue_titre".localized(table: "MenuViewController"), message: message, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "alerte_changer_langue_close_action".localized(table: "MenuViewController"), style: .destructive) { _ in
                UserDefaults.standard.set([langCode], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                exit(EXIT_SUCCESS)
            }
            confirmAlertCtrl.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: "alerte_action_Cancel".localized(table: "Common"), style: .cancel, handler: nil)
            confirmAlertCtrl.addAction(cancelAction)
            
            present(confirmAlertCtrl, animated: true, completion: nil)
        }
    }
    
    // MARK: - IBActions
    /// Action effectuée lors du clic sur le bouton des langues. 
    ///
    /// Affiche un popover avec les différentes langues disponibles et appelle la fonction `changeToLanguage` sur la langue sélectionnée.
    ///
    /// - Parameter sender: Le bouton langues.
    @IBAction func changerLangue(_ sender: UIButton)
    {
        //Alerte choix des langues
        
        //LocalizedStrings
        let titre = "alerte_langue_titre".localized(table: "MenuViewController")
        let cancel = "alerte_action_Cancel".localized(table: "Common")
        
        //Alerte
        let alerte = UIAlertController(title: titre, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        for langue in RestApiManager.sharedInstance.langues
        {
            //Pour chaque langue, ajouter le bouton dans l'actionSheet et effectuer les modifications (bouton : titre + drapeau, langue de l'appli).
            alerte.addAction(UIAlertAction(title: langue, style: UIAlertActionStyle.default, handler: { alertAction in
                SpeedLog.print("\(langue) selected as new language.")

                //Changement de langue de l'interface
                let liste_langues = Bundle.main.localizations.filter({ $0 != "Base" })
                for code in liste_langues
                {
                    if let locale_str = Locale(identifier: code).localizedString(forLanguageCode: code)
                    {
                        if locale_str == langue.lowercased() || locale_str == langue
                        {
                            self.changeToLanguage(code)
                            return
                        }
                    }
                }
            }))
        }
        alerte.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alerte, animated: true, completion: nil)
    }
    
    /// Emmène l'utilisateur vers une page de connexion.
    ///
    /// - Parameter sender: Le bouton de connexion.
    @IBAction func seConnecter(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToConnexion", sender: self)
    }
    
    /// Emmène l'utilisateur vers une page d'inscription.
    ///
    /// - Parameter sender: Le bouton d'inscription.
    @IBAction func sInscrire(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToInscription", sender: self)
    }

    /// Emmène l'utilisateur vers une page d'accès au forum.
    ///
    /// - Parameter sender: Le bouton d'accès au forum.
    @IBAction func accesForum(_ sender: UIButton)
    {
        //performSegueWithIdentifier("goToForum", sender: self)
    }
    
    /// Emmène l'utilisateur vers une page avec une liste des événements disponibles.
    ///
    /// - Parameter sender: Le bouton de liste des événements.
    @IBAction func consulterEvenements(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToListeEvenements", sender: self)
    }
}

