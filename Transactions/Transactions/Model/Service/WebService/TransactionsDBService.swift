//
//  TransactionsDBService.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import Foundation

class TransactionWebService: ServiceAble{
    private let urlString = "https://private-ddc1b2-transactions14.apiary-mock.com/transactions"
    
    func call(completionHandler: @escaping (Result<[TransactionDataModel], TDError>)->()){
        let request = WebServiceRequest.init(url: urlString, resultType: .Data, timeOutSession: 30)
        WebServiceAPI.call(request: request) { (result) in
            switch result{
            case .success(let response):
                let data = response.resultData as! Data
                let decoder = JSONDecoder.init()
                var transaction: [TransactionDataModel]
                do {
                    transaction = try decoder.decode([TransactionDataModel].self, from: data)
                    transaction = transaction.map({ (model) -> TransactionDataModel in
                        var newModel = model
                        newModel.setupEffectiveDate()
                        return newModel
                    })
                    completionHandler(Result.success(transaction))
                } catch {
                    completionHandler(Result.fail(TDError.init(error)))
                }
            case .fail(let error):
                completionHandler(Result.fail(error))
            }
        }
    }
    
}
