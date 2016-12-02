//
//  InscriptionViewController.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 01/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import UIKit

class InscriptionViewController: UIViewController
{
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cityNearby: UIPickerView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}