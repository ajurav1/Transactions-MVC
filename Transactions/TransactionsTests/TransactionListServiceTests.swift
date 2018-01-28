//
//  TransactionListServiceTests.swift
//  TransactionsTests
//
//  Created by MacBook on 29/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import XCTest
@testable import Transactions

class TransactionListServiceTests: XCTestCase {
    
    var serviceUnderTest: TransactionListService!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        serviceUnderTest = TransactionListService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        serviceUnderTest = nil
    }
    
    // XCTAssert to test model
    func test_TransactionWithTotalAmountDataModel_is_computed_when_given_transactions() {
        
        //Positive Test Case
        
        // 1. given
        var transaction1 = TransactionDataModel.init(id: 1, description: "Opel", amount: -10.00, effectiveDate: "2017-12-21T08:40:51.620Z", effectiveDateValue: nil)
        transaction1.setupEffectiveDate()
        var transaction2 = TransactionDataModel.init(id: 2, description: "Refund", amount: 80.00, effectiveDate: "2017-12-11T08:40:51.620Z", effectiveDateValue: nil)
        transaction2.setupEffectiveDate()
        var transaction3 = TransactionDataModel.init(id: 3, description: "Opel", amount: -20.00, effectiveDate: "2017-01-01T08:40:51.620Z", effectiveDateValue: nil)
        transaction3.setupEffectiveDate()
        var transaction4 = TransactionDataModel.init(id: 4, description: "Opel", amount: -30.00, effectiveDate: "2017-01-13T08:40:51.620Z", effectiveDateValue: nil)
        transaction4.setupEffectiveDate()
        
        let expectedTransactionWithAmount = TransactionWithTotalAmountDataModel.init(transactions: [transaction3, transaction4, transaction2, transaction1], total: 20)
        
        // 2. when
        var transactionWithAmount = serviceUnderTest.mapTransaction([transaction1, transaction2, transaction3, transaction4])
        
        // 3. then
        XCTAssertEqual(transactionWithAmount.total, expectedTransactionWithAmount.total, "Total computed wrong")
        XCTAssertEqual(transactionWithAmount.transactions[0].id, expectedTransactionWithAmount.transactions[0].id, "Transactions not sorted by date")
        
        //Negative Test Case
        
        // 1. given
        let unExpectedTransactionWithAmount = TransactionWithTotalAmountDataModel.init(transactions: [transaction2, transaction4, transaction1, transaction3], total: 50)
        
        // 2. when
        transactionWithAmount = serviceUnderTest.mapTransaction([transaction1, transaction2, transaction3, transaction4])
        
        // 3. then
        XCTAssert(transactionWithAmount.total != unExpectedTransactionWithAmount.total, "Total computed wrong")
        XCTAssert(transactionWithAmount.transactions[0].id != unExpectedTransactionWithAmount.transactions[0].id, "Transactions not sorted by date")
        
    }

    
}
