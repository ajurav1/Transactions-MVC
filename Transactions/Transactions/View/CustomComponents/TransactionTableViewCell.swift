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
    @IBOutlet private var descriptionLabel:UILabel!
    @IBOutlet private var amountLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func applyDataFrom(model: ViewModelAble) {
        guard let transaction = model as? TransactionViewModel else {
            fatalError("Invalid data applied to TransactionCell")
        }
//        self.amountLabel.text = String.init(format: "%0.2f%@", transaction.amount,Constants.currencySymbol)
//        self.amountLabel.textColor =  transaction.amount < 0 ? UIColor.red : UIColor.black
//        self.descriptionLabel.text = transaction.description
//        self.effectiveDateLabel.text = "NA"//DateUtility.stringFromDate(date: transation.effectiveDateValue!)
    }

}
