//
//  TransactionListDataSource.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import UIKit

protocol TransactionListDataManagerDelegate: class {
    func listDidTapTransaction(transaction: TransactionViewModel)
}

class TransactionListDataManager: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    private var transactions: [TransactionViewModel]
    weak var delegate: TransactionListDataManagerDelegate?
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = transactions[indexPath.row]
        self.delegate?.listDidTapTransaction(transaction: transaction)
    }
}
