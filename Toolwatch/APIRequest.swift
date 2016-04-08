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
    private var valuesToModify:[String:String]
    private var model:SyncronizableModel!
    private var callback : ((SyncronizableModel, Int)-> Void)?
    private var requestCreated:Double
    private let baseUrl:String = "https://tw-prepod-pr-126.herokuapp.com/api/"
    
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
    init(httpMethod:Alamofire.Method, url:String, model:SyncronizableModel! = nil, parameters:[String: String] = [String: String](),
        valuesToModify:[String:String] = [String: String]()){
            
            self.httpMethod = httpMethod
            self.url = baseUrl+url
            self.model = model
            self.parameters = parameters
            
            if(APIRequest.apiKey != nil){
                self.parameters["X-API-KEY"] = APIRequest.apiKey
            }
            
            self.valuesToModify = valuesToModify
            self.requestCreated = NSDate().timeIntervalSince1970
    }
    
    /**
     Adds a key to change in the model
     
     - parameter key:   <#key description#>
     - parameter value: <#value description#>
     
     - returns: <#return value description#>
     */
    func addChangeValue(key:String, value:String) -> APIRequest{
        valuesToModify[key] = value
        return self
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
    
    func callback(callback: (SyncronizableModel, Int)-> Void) -> APIRequest{
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
        
        Alamofire.request(self.httpMethod, self.url, parameters: self.parameters).validate().responseJSON {
            
            response in switch response.result {
                
            case .Success:
                self.updateModel(response)
                
            case .Failure(let error):
                print(error)
                
            }
            
            let returnValue = (response.response?.statusCode)!
            print(returnValue)
            
            if(self.callback != nil){
                self.callback!(self.model, returnValue)
            }
        }
    }
    
    /**
     Updates the given Syncable Model
     
     - parameter response: <#response description#>
     */
    private func updateModel(response: Response<AnyObject, NSError>) -> Void {
        if let value = response.result.value {
            let json = JSON(value)
            
            if let apiKey = json["key"].string{
                APIRequest.apiKey = apiKey;
            }
            
            self.model.externalId = json["id"].intValue
            self.model.lastSync = NSDate().timeIntervalSince1970
            
            for(key, value) in self.valuesToModify{
                
                self.model.setValue(json[value].object, forKey: key)
            }
            print("JSON: \(json)")
            
        }
    }
    
}