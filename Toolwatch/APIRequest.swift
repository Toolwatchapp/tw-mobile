//
//  APIRequest.swift
//  Toolwatch
//
//  Created by math on 2016-02-25.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation
import Alamofire

class APIRequest{
    
    private var httpMethod:Alamofire.Method
    private var url:String
    private var parameters:[String: String]
    private var callback : ((JSON, Int)-> Void)?
    private var requestCreated:Double
    private let baseUrl:String = "https://toolwatch.io/api/"
    
    private static var apiKey:String!
    
    /**
     Construcs an APIRequest
     
     - parameter httpMethod:     <#httpMethod description#>
     - parameter url:            <#url description#>
     - parameter model:          <#model description#>
     - parameter parameters:     <#parameters description#>
     - parameter valuesToModify: <#valuesToModify description#>
     
     - returns: <#return value description#>
     */
    init(httpMethod:Alamofire.Method, url:String, parameters:[String: String] = [String: String]()){
            
            self.httpMethod = httpMethod
            self.url = baseUrl+url
            self.parameters = parameters
            
            if(APIRequest.apiKey != nil){
                self.parameters["X-API-KEY"] = APIRequest.apiKey
            }
            self.requestCreated = NSDate().timeIntervalSince1970
    }
    
    /**
     Adds a parameter for the query
     
     - parameter key:   <#key description#>
     - parameter value: <#value description#>
     
     - returns: <#return value description#>
     */
    func addParameter(key:String, value:String) -> APIRequest{
        
        parameters[key] = value
        return self
    }
    
    func callback(callback: (JSON, Int)-> Void) -> APIRequest{
        self.callback = callback;
        return self;
    }
    
    /**
     Executes the query or store it
     
     - returns: <#return value description#>
     */
    func execute() -> Void {
        
        let status = Reach().connectionStatus()
        
        switch status {
        case .Unknown, .Offline:
            WatchesViewController.pendingRequests.append(self);
            
        case .Online(.WWAN), .Online(.WiFi):
            self.executeQuery();
            
        }
    }
    
    /**
     Executes the query
     
     - returns: <#return value description#>
     */
    private func executeQuery(){
        
        print("=====DEBUG======")
        print(self.httpMethod)
        print(self.url)
        print(self.parameters)
        print("=====RESULT====")
        
        var json:JSON! = nil
        
        Alamofire.request(self.httpMethod, self.url, parameters: self.parameters).validate().responseJSON {
            
            response in response.result
            
            if let value = response.result.value {
                json = JSON(value)
                
                if let apiKey = json["key"].string{
                    APIRequest.apiKey = apiKey;
                }
            }
            
            
            let returnValue = (response.response?.statusCode)!
            
            print(returnValue)
            if(json != nil){
                print(json);
            }
            print("===========")
            

            if(self.callback != nil && json != nil){
                self.callback!(json, returnValue);
            }else{
                self.callback!(nil, returnValue);
            }
        }
    }
    
}