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
        //print("deze is on fire")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func seConnecter(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToConnexion", sender: self)
    }
    
    @IBAction func sInscrire(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToInscription", sender: self)
    }

    @IBAction func accesForum(_ sender: UIButton)
    {
        //performSegueWithIdentifier("goToForum", sender: self)
    }
    
    @IBAction func consulterEvenements(_ sender: UIButton)
    {
        //performSegueWithIdentifier("goToListeEvenements", sender: self)
    }
}

