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
    
    var httpMethod:Alamofire.Method
    var url:String
    var parameters:[String: String]
    var valuesToModify:[String:String]
    var model:SyncronizableModel
    var requestCreated:Double
    let baseUrl:String = "https://tw-prepod-pr-126.herokuapp.com/api/"
    
    private static var apiKey:String!
    
    init(httpMethod:Alamofire.Method, url:String, model:SyncronizableModel, parameters:[String: String] = [String: String](),
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
    
    func addChangeValue(key:String, value:String) -> APIRequest{
        valuesToModify[key] = value
        return self
    }
    
    func addParameter(key:String, value:String) -> APIRequest{
        
        parameters[key] = value
        return self
    }
    
    func execute() -> Int! {
        
        let status = Reach().connectionStatus()
        
        switch status {
            case .Unknown, .Offline:
                WatchesViewController.pendingRequests.append(self);
                return 0
            
            case .Online(.WWAN), .Online(.WiFi):
                
                var returnValue:Int!
            
                Alamofire.request(self.httpMethod, self.url, parameters: self.parameters).validate().responseJSON {
                    
                    response in switch response.result {
                    case .Success:
                        
                        
                        if let value = response.result.value {
                            let json = JSON(value)
                            
                            if let apiKey = json["key"].string{
                                APIRequest.apiKey = apiKey;
                                print("Yihaa");
                            }
                            
                            self.model.externalId = json["id"].intValue
                            self.model.lastSync = NSDate().timeIntervalSince1970
                            
                            for(key, value) in self.valuesToModify{
                                
                                self.model.setValue(json[value].object, forKey: key)
                            }
                            
                            print("JSON: \(json)")
                            returnValue = (response.response?.statusCode)!
                            print(returnValue)
                        }
                        
                    case .Failure(let error):
                        print(error)
                    }
                }
                
            return returnValue
        }
    }

}