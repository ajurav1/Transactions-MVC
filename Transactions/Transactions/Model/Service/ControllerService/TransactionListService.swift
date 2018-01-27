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
    
    func getTransactions(){
        getTransactionsFromServer()
    }
    
    private func getTransactionsFromServer(){
        webservice.call { (result) in
            switch result{
            case .success(let transactions): print(transactions)
            case .fail(let error): print(error)
            }
        }
    }
}
