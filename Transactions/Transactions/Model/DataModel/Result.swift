//
//  Result.swift
//  Transactions
//
//  Created by MacBook on 27/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import Foundation

enum Result<T,U: TDError>{
    case success(T)
    case fail(U)
}


class TDError {
    var error: Error
    var code: Int?
    var description: String?
    
    init(_ error: Error) {
        self.error = error
    }
    
    init(_ error: Error, code: Int? = nil, description: String? = nil) {
        self.error = error
        self.code = code
        self.description = description
    }
}
