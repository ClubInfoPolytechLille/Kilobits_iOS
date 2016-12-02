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
    
    @IBAction func Cancel(sender: UIBarButtonItem)
    {
        performSegueWithIdentifier("goToMenuMigrantFromProfile", sender: self)
    }
    
    @IBAction func Save(sender: UIBarButtonItem)
    {
        //set user info if changed
    }
    
    @IBAction func CloseAccount(sender: UIButton)
    {
        //Send request to delete user
        dismissViewControllerAnimated(true, completion: nil)
    }
}


