//
//  ViewController.swift
//  Transactions
//
//  Created by MacBook on 25/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import UIKit

class TransactionListController: UIViewController {

    @IBOutlet var service: TransactionListService!
    var customView: TransactionListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customView = self.view as! TransactionListView
        customView.delegate = self
        customView.setUpList()
        service.getTransactions { [weak self] (result) in
            switch result{
            case .success(let transaction):
                self?.customView.reloadList(transactions: (self?.map(model: transaction.transactions))!)
                self?.customView.refreshTotalAmount(amount: (self?.map(model: transaction))!)
            case .fail(let error): break
                
            }
            
        }
    }
    
    private func map(model: [TransactionDataModel])-> [TransactionViewModel]{
        return model.map { (dataModel) -> TransactionViewModel in
            var model = dataModel
            guard let date = model.effectiveDateValue else{ return
                TransactionViewModel.init(date: "NA", amount: String.init(format: "%0.2f%@",model.amount,"$"), detail: model.description, transactionType: .none)
            }
            
            var transactionType: TransactionViewModel.TransactionType = .none
            if model.amount < 0{
                transactionType = .debit
            }else if model.amount > 0{
                transactionType = .credit
            }
            
            return TransactionViewModel.init(date: Utilities.dateConversion(date: date, dateFormat: "dd MMM, yyyy hh:mm a"), amount: String.init(format: "%@ %0.2f","$",abs(model.amount)), detail: model.description, transactionType: transactionType)
        }
    }
    
    private func map(model: TransactionWithTotalAmountDataModel)-> AmountViewModel{
        return AmountViewModel.init(total: String.init(format: "%@ %0.2f","$",model.total))
    }
    
    private func displayAlert(title: String, message: String){
        let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TransactionListController: TransactionListViewDelegate{
    func didTapTransaction(_ transaction: TransactionViewModel) {
        displayAlert(title: "Transaction Detail", message: transaction.detail)
    }
    
    
    
}

