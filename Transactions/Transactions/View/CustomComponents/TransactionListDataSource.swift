//
//  TransactionListDataSource.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import UIKit

class TransactionListDataSource: NSObject, UITableViewDataSource{
    
    private var transactions: [TransactionViewModel]
    
    init(transactions: [ViewModelAble]) {
        guard let transaction = transactions as? [TransactionViewModel] else {
            self.transactions = []
            return
        }
        self.transactions = transaction
    }
    
    func updateTransactions(transactions: [ViewModelAble]){
        guard let transaction = transactions as? [TransactionViewModel] else {
            self.transactions = []
            return
        }
        self.transactions = transaction
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
}
