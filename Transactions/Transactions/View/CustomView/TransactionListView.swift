//
//  TransactionListView.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import UIKit

class TransactionListView: UIView {

    @IBOutlet private var list: UITableView!
    @IBOutlet private var totalAmountView: UIView!
    @IBOutlet private var totalAmountLabel: UILabel!
    private var transactions: [TransactionViewModel] = []{
        didSet{
            if transactions.count > 0{
                totalAmountView.isHidden = false
            }else{
                totalAmountView.isHidden = true
            }
        }
    }
    
    private var listDataSource = TransactionListDataSource.init(transactions: [])
    
    func setUpList(){
        transactions = []
        list.dataSource = listDataSource
    }
    
    func reloadList(transactions: [TransactionViewModel]?){
        if let value = transactions{
            self.transactions = value
        }
        listDataSource.updateTransactions(transactions: self.transactions)
        list.reloadData()
    }
    
    func refreshTotalAmount(amount: AmountViewModel){
        totalAmountLabel.text = amount.total
    }
    
    
    
}
