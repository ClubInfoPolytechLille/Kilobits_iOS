//
//  ProfileViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 02/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController
{
    // MARK: - Initialisation
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //get user info and load it all
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func Cancel(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "goToMenuMigrantFromProfile", sender: self)
    }
    
    @IBAction func Save(_ sender: UIBarButtonItem)
    {
        //set user info if changed
    }
    
    @IBAction func CloseAccount(_ sender: UIButton)
    {
        //Send request to delete user
        dismiss(animated: true, completion: nil)
    }
}


