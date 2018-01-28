//
//  Utility+Date.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import Foundation

extension Utilities{
    
    static func dateConversion(date: String, dateFormat: String) -> Date? {
        let dateformatter = DateFormatter.init()
        dateformatter.dateFormat = dateFormat
        let dateValue = dateformatter.date(from: date)
        return dateValue
        
    }
    
    static func dateConversion(date: Date, dateFormat: String) -> String {
        let dateformatter = DateFormatter.init()
        dateformatter.dateFormat = dateFormat
        return dateformatter.string(from: date)
    }
}
