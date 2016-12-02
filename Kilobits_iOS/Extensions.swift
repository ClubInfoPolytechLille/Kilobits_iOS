//
//  Extensions.swift
//  Kilobits_iOS
//
//  Created by marianne Butaye on 02/12/2016.
//  Copyright © 2016 Club Info. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIViewController
extension UIViewController {
    //Le clavier disparaît si un toucher est détecté
    func hideKeyboardWithTouch()
    {
        let touch: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(touch)
    }
    
    //Le clavier disparaît
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
