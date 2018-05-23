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

struct TransactionDataModel: DataModelAble{
    typealias dataType = [TransactionDataModel]
    
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
extension TransactionDataModel{
    //overriding, as we need to map transactions after decoding
    static func getDataModel(_ jsonData: Data, completionHandler: @escaping (Result<dataType, TDError>)->()){
        let decoder = JSONDecoder()
        do {
            var transactions = try decoder.decode(dataType.self, from: jsonData)
            transactions = transactions.map({ (model) -> TransactionDataModel in
                var newModel = model
                newModel.setupEffectiveDate()
                return newModel
            })
            completionHandler(Result.success(transactions))
        } catch {
            completionHandler(Result.fail(TDError.init(error)))
        }
    }
}

