//
//  TransactionListService.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import Foundation

class TransactionListService: NSObject, ServiceAble{
    
    let webservice = TransactionWebService()
    
    func getTransactions(completionHandler: @escaping (Result<TransactionWithTotalAmountDataModel, TDError>)->()){
        getTransactionsFromServer { (result) in
            switch result{
            case .success(let transactions):
                let sortedTransactions = transactions.sorted(by: { (model0, model1) -> Bool in
                    return (model0.effectiveDateValue?.compare(model1.effectiveDateValue!)) == .orderedAscending
                })
                let amount = sortedTransactions.reduce(0, {$0 + $1.amount})
                let transactionWithTotal = TransactionWithTotalAmountDataModel.init(transactions: sortedTransactions, total: amount)
                DispatchQueue.main.async {
                    completionHandler(Result.success(transactionWithTotal))
                }
            case .fail(let error):
                DispatchQueue.main.async {
                    completionHandler(Result.fail(error))
                }
            }
        }
    }
    
    private func getTransactionsFromServer(completionHandler: @escaping (Result<[TransactionDataModel], TDError>)->()){
        webservice.call { (result) in
              completionHandler(result)
            }
        }
}
