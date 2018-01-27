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
        customView.setUpList()
        service.getTransactions { (result) in
            switch result{
            case .success(let transaction): break
                //self.customView.reloadList(transactions: transaction.transactions)
            case .fail(let error): break
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

