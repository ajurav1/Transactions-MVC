//
//  TransactionDataModel.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import Foundation

struct TransactionWithTotalAmountDataModel{
    var transactions: [TransactionDataModel]
    var total: Double
}

struct TransactionDataModel: Decodable, DataModelAble{
    var id: Int
    var description: String
    var amount: Double
    var effectiveDate: String
    
    var effectiveDateValue: Date?
    
    mutating func setupEffectiveDate(){
        effectiveDateValue = Utilities.dateConversion(date: effectiveDate, dateFormat: serverDateFormat())
    }
    
    private func serverDateFormat()-> String{
        return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    }
}
