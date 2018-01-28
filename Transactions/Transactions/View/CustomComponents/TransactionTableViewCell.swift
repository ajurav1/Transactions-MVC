//
//  TransactionTableViewCell.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet private var effectiveDateLabel:UILabel!
    @IBOutlet private var amountLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func applyDataFrom(model: TransactionViewModel) {
        self.amountLabel.text = model.amount
        self.effectiveDateLabel.text = model.date
        switch model.transactionType {
        case .credit: self.amountLabel.textColor = UIColor.green
        case .debit: self.amountLabel.textColor = UIColor.red
        default: break
        }
    }

}
