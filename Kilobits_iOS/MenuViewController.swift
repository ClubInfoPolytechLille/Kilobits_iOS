//
//  ViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 01/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("deze is on fire")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func seConnecter(sender: UIButton)
    {
        performSegueWithIdentifier("goToConnexion", sender: self)
    }
    
    @IBAction func sInscrire(sender: UIButton)
    {
        performSegueWithIdentifier("goToInscription", sender: self)
    }

}
