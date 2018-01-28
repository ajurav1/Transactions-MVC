//
//  TransactionViewModel.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import Foundation

struct AmountViewModel: ViewModelAble{
    var total: String
}

struct TransactionViewModel: ViewModelAble{
    
    enum TransactionType{
        case credit
        case debit
        case none
    }
    
    var date: String
    var amount: String
    var transactionType: TransactionType
}
