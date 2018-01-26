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
    private var listDataSource = TransactionListDataSource.init(transactions: [])
    
    func setUpList(){
        list.dataSource = listDataSource
    }
    
    func reloadList(transactions: [ViewModelAble]){
        listDataSource.updateTransactions(transactions: transactions)
        list.reloadData()
    }
    
}
