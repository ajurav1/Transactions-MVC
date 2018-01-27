//
//  WebServiceAPI.swift
//  Transactions
//
//  Created by MacBook on 27/01/18.
//  Copyright © 2018 AbhimanuJindal. All rights reserved.
//

import Foundation

public enum ResultType{
    case String
    case Data
    case JSON
}

public enum WebServiceError: Error{
    case invalidResponse
    case resultValidationFailed
    case networkNotReachable
    case invalidUrl
    case jsonParsingFailed
}

public struct WSResponse {
    public var request: WebServiceRequest?
    public var response: HTTPURLResponse?
    public var resultData: WSResult?
    
    public init(request: WebServiceRequest?, response: HTTPURLResponse?, resultData: WSResult?){
        self.request = request
        self.response = response
        self.resultData = resultData
    }
}


public protocol WSResult {}
extension String: WSResult{}
extension Data: WSResult{}
extension Json: WSResult{}

public struct Json {
    public var jsonData: AnyObject?
    public init(){}
}

public struct WebServiceRequest{
    public var url: String = ""
    public var resultType: ResultType = .String
    public var timeOutSession = 60
}


struct WebServiceAPI {
 
    static func call(request: WebServiceRequest, completionHandler: @escaping (Result<WSResponse, TDError>) -> Void){
        
        guard let url = URL.init(string: request.url) else{
            completionHandler(Result.fail(TDError.init(WebServiceError.invalidUrl)))
            return
        }
        
        let urlRequest = URLRequest.init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: TimeInterval(request.timeOutSession))
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            //1 - Validate Response
            if let error = validateResponse(error: error, response: response){
                completionHandler(Result.fail(error))
                return
            }
            
            switch request.resultType {
            case .String:
                let description = String(data: data!, encoding: .utf8)
                if description != nil{
                    completionHandler(Result.success(WSResponse.init(request: request, response: response as? HTTPURLResponse, resultData: description!)))
                }else{
                    completionHandler(Result.success(WSResponse.init(request: request, response: response as? HTTPURLResponse, resultData: "")))
                }
                return
            case .Data:
                if data != nil{
                    completionHandler(Result.success(WSResponse.init(request: request, response: response as? HTTPURLResponse, resultData: data!)))
                }
                else{
                    completionHandler(Result.success(WSResponse.init(request: request, response: response as? HTTPURLResponse, resultData: Data.init())))
                }
                return
            case .JSON:
                do {
                    //Parsing data & get the Array
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                    var json = Json()
                    json.jsonData = jsonData
                    completionHandler(Result.success(WSResponse.init(request: request, response: response as? HTTPURLResponse, resultData: json)))
                    
                } catch {
                    //Print the error
                completionHandler(Result.fail(TDError.init(WebServiceError.jsonParsingFailed)))
                }
                return
            }
        }
        dataTask.resume()
    }
    
    static func validateResponse(error: Error?, response: URLResponse?)-> TDError?{
        //1.
        if error != nil{
            return TDError.init(error!)
        }
        //2.
        guard let httpResponse = response as? HTTPURLResponse else{
            return TDError.init(WebServiceError.invalidResponse)
        }
        //3.
        if httpResponse.statusCode != 200{
            return TDError.init(WebServiceError.invalidResponse)
        }
        return nil
    }
    
}
