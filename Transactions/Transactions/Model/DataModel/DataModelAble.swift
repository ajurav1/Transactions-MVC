//
//  DataModelable.swift
//  Transactions
//
//  Created by MacBook on 26/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import Foundation

protocol DataModelAble: Decodable{
    associatedtype dataType : Decodable
    static func getDataModel(_ jsonData: Data, completionHandler: (Result<dataType, TDError>)->())
}
extension DataModelAble{
    //default implementation for decoding
    static func getDataModel(_ jsonData: Data, completionHandler: (Result<dataType, TDError>)->()){
        let decoder = JSONDecoder()
        do {
            let apiResponse = try decoder.decode(dataType.self, from: jsonData)
            completionHandler(Result.success(apiResponse))
        } catch {
            completionHandler(Result.fail(TDError.init(error)))
        }
    }
}
