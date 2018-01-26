//
//  TransactionDataModel.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import Foundation

struct TransactionDataModel: Decodable, DataModelAble{
    private let dateFormat  = "yyyy-MM-dd'T'HH:mm:ss.Z"
    var id: Int
    var description: String
    var amount: Double
    var effectiveDate: String
    lazy var effectiveDateValue: Date? = {
        return Utilities.dateConversion(date: effectiveDate, dateFormat: dateFormat)
    }()
}
