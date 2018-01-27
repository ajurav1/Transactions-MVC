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
    
    private var transactions: [ViewModelAble] = []{
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
    
    func reloadList(transactions: [ViewModelAble]){
        self.transactions = transactions
        listDataSource.updateTransactions(transactions: self.transactions)
        list.reloadData()
    }
    
}
