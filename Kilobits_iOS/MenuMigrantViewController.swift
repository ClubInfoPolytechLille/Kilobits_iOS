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
    
    @IBAction func disconnect(sender: UIBarButtonItem)
    {
        self.navigationController!.navigationBar.hidden = true
        performSegueWithIdentifier("goToMenuFromMenuMigrant", sender: self)
    }
    
    @IBAction func goToProfile(sender: UIBarButtonItem)
    {
        performSegueWithIdentifier("goToProfile", sender: self)
    }
}

