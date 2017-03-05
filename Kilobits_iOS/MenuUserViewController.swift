//
//  MenuUserViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 02/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import Foundation
import UIKit
import SpeedLog

class MenuUserViewController: UIViewController
{
    // MARK: - Initialisation
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //print("deze is on fire")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "goToListeEvenementsFromMenuUser":
            guard let navController = segue.destination as? UINavigationController else {
                fatalError("Unexpected navigation destination: \(segue.destination)")
            }
            
            guard let viewController = navController.viewControllers.first! as? ListeEvenementsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
        
            viewController.comingFrom = "MenuUser"
        
        default: break
        }
    }
    
    // MARK: - IBActions
    @IBAction func disconnect(_ sender: UIBarButtonItem)
    {
        SpeedLog.print("Utilisateur \(RestApiManager.sharedInstance.user!.pseudo) déconnecté")
        self.navigationController!.navigationBar.isHidden = true
        RestApiManager.sharedInstance.user = nil
        performSegue(withIdentifier: "goToMenuFromMenuUser", sender: self)
    }
    
    @IBAction func goToProfile(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "goToProfileFromMenuUser", sender: self)
    }
    
    @IBAction func goToListeEvenements(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToListeEvenementsFromMenuUser", sender: self)
    }
}

