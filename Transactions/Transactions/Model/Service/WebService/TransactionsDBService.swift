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
                TransactionDataModel.getDataModel(data, completionHandler: { (result) in
                    completionHandler(result)
                })
            case .fail(let error):
                completionHandler(Result.fail(error))
            }
        }
    }
    
}
