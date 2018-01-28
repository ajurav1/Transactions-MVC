//
//  TransactionViewModel.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import UIKit

struct AmountViewModel: ViewModelAble{
    var total: String
}

struct TransactionViewModel: ViewModelAble{
    var date: String
    var amount: String
    var detail: String
    var amountTextColor: UIColor
}
