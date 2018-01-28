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
        customView.setUpView()
        customView.updateViewState(.idle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customView.updateViewState(.loading)
        service.getTransactions { [weak self] (result) in
            switch result{
            case .success(let transaction):
                let viewTransactions = self?.map(model: transaction.transactions)
                if viewTransactions?.count == 0{
                    self?.customView.updateViewState(.noDataFound)
                }else{
                    self?.customView.updateViewState(.loaded)
                }
                self?.customView.reloadList(transactions: viewTransactions)
                self?.customView.refreshTotalAmount(amount: (self?.map(model: transaction))!)
            case .fail( _):
                self?.customView.updateViewState(.errorInLoading)
                self?.displayAlert(title: "Error", message: "Unable to get Transactions")
            }
            
        }
    }
    
    private func map(model: [TransactionDataModel])-> [TransactionViewModel]{
        return model.map { (dataModel) -> TransactionViewModel in
            var model = dataModel
            guard let date = model.effectiveDateValue else{ return
                TransactionViewModel.init(date: "NA", amount: String.init(format: "%0.2f%@",model.amount,"$"), detail: model.description, amountTextColor: getTransactionColor(amount: 0))
            }
            
            return TransactionViewModel.init(date: Utilities.dateConversion(date: date, dateFormat: "dd MMM, yyyy hh:mm a"), amount: String.init(format: "%@ %0.2f","$",abs(model.amount)), detail: model.description, amountTextColor: getTransactionColor(amount: model.amount))
        }
    }
    
    private func map(model: TransactionWithTotalAmountDataModel)-> AmountViewModel{
        return AmountViewModel.init(total: String.init(format: "%@ %0.2f","$",model.total))
    }
    
    private func getTransactionColor(amount: Double)->UIColor{
        var color = UIColor.black
        if amount < 0{
            color = UIColor.red
        }else if amount > 0{
            color = UIColor.green
        }
        return color
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

