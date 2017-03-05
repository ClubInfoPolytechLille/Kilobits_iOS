//
//  DateExtension.swift
//  Kilobits_iOS
//
//  Created by Marianne on 04/03/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation

// Extension de Date pour la conversion Date -> String
extension Date
{
    /// Transforme une Date en String.
    ///
    /// - Returns: La chaîne de caractères correspondant à la date au format **dd/MM/yyyy, HH:mm**.
    func toString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        return dateFormatter.string(from: self)
    }
}
