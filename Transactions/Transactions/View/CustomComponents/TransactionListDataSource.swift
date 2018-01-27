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
    
    init(transactions: [TransactionViewModel]) {
        self.transactions = transactions
    }
    
    func updateTransactions(transactions: [TransactionViewModel]){
        self.transactions = transactions
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as! TransactionTableViewCell
        cell.applyDataFrom(model: transactions[indexPath.row])
        return cell
    }
}
