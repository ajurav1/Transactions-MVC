//
//  TransactionListView.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import UIKit

protocol TransactionListViewDelegate: class {
    func didTapTransaction(_ transaction: TransactionViewModel)
}

class TransactionListView: UIView {

    @IBOutlet private var list: UITableView!
    @IBOutlet private var totalAmountView: UIView!
    @IBOutlet private var totalAmountLabel: UILabel!
    
    weak var delegate: TransactionListViewDelegate?
    
    private var transactions: [TransactionViewModel] = []{
        didSet{
            if transactions.count > 0{
                totalAmountView.isHidden = false
            }else{
                totalAmountView.isHidden = true
            }
        }
    }
    
    private var listDataManager = TransactionListDataManager.init(transactions: [])
    
    func setUpList(){
        transactions = []
        list.dataSource = listDataManager
        list.delegate = listDataManager
        listDataManager.delegate = self
    }
    
    func reloadList(transactions: [TransactionViewModel]?){
        if let value = transactions{
            self.transactions = value
        }
        listDataManager.updateTransactions(transactions: self.transactions)
        list.reloadData()
    }
    
    func refreshTotalAmount(amount: AmountViewModel){
        totalAmountLabel.text = amount.total
    }
    
}

extension TransactionListView: TransactionListDataManagerDelegate{
    
    func listDidTapTransaction(transaction: TransactionViewModel) {
        self.delegate?.didTapTransaction(transaction)
    }
}
