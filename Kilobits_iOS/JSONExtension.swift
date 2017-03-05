//
//  JSONExtension.swift
//  Kilobits_iOS
//
//  Created by Marianne on 04/03/2017.
//  Copyright © 2017 Club Info. All rights reserved.
//

import Foundation
import SwiftyJSON

// Extension de JSON pour les dates
extension JSON
{
    
    /// La date, si elle existe, correspondant au JSON.
    public var date: Date? {
        get {
            if let str = self.string {
                return JSON.jsonDateFormatter.date(from: str)
            }
            return nil
        }
    }
    
    /// La date correspondant au JSON.
    public var dateValue: Date {
        get {
            return JSON.jsonDateFormatter.date(from: self.string!)!
        }
    }
    
    
    /// Un formatter de date de format **yyyy-MM-dd HH:mm:ss** pour pouvoir déchiffrer une date en JSON.
    private static let jsonDateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"/*.SSS'Z'"*/ //avec zone
        format.timeZone = TimeZone(secondsFromGMT: 0)
        return format
    }()
}
