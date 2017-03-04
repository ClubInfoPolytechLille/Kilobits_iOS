//
//  MenuMigrantViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 02/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import Foundation
import UIKit

class MenuMigrantViewController: UIViewController
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
    
    // MARK: - IBActions
    @IBAction func disconnect(_ sender: UIBarButtonItem)
    {
        self.navigationController!.navigationBar.isHidden = true
        RestApiManager.sharedInstance.user = nil
        performSegue(withIdentifier: "goToMenuFromMenuMigrant", sender: self)
    }
    
    @IBAction func goToProfile(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "goToProfile", sender: self)
    }
}

