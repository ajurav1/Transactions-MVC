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
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: TransactionListViewDelegate?
    
    enum ViewState {
        case loading, loaded, noDataFound, errorInLoading, idle
    }
    
    private var viewState: ViewState = .idle{
        didSet{
            switch viewState {
            case .loading:
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                list.isHidden = true
            case .loaded:
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                list.isHidden = false
            default:
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                list.isHidden = true
            }
        }
    }
    
    private var transactions: [TransactionViewModel] = []
    
    private var listDataManager = TransactionListDataManager.init(transactions: [])
    
    func setUpView(){
        setUpList()
    }
    
    private func setUpList(){
        transactions = []
        list.dataSource = listDataManager
        list.delegate = listDataManager
        listDataManager.delegate = self
    }
    
    func updateViewState(_ viewState: ViewState){
        self.viewState = viewState
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
