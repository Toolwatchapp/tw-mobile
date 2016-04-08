//
//  API.swift
//  Toolwatch
//
//  Created by math on 2016-04-07.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation
import Alamofire

public class API{
    
    
    static func login(email:String, password:String, callback:(result:Bool) -> Void) -> Void{
        
        APIRequest(httpMethod: Alamofire.Method.PUT, url: "users")
            .addParameter("email", value: email)
            .addParameter("password", value: password)
            .callback({ (model:SyncronizableModel, response:Int) in
                callback(result: response == HTTPCode.OK)
            })
            .execute();
    }
    
    static func registerEmail(email:String, password:String, name:String, firstName:String, country:String, callback:(result:Bool) -> Void) -> Void{
        
        APIRequest(httpMethod: Alamofire.Method.POST, url: "users")
            .addParameter("email", value: email)
            .addParameter("password", value: password)
            .addParameter("name", value: name)
            .addParameter("firstname", value: firstName)
            .addParameter("country", value: country)
            .callback({ (model:SyncronizableModel, response:Int) in
                callback(result: response == HTTPCode.OK)
            })
            .execute()
    }
}