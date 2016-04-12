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
            .callback({ (response:JSON, responseCode:Int) in
                callback(result: responseCode == HTTPCode.OK)
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
            .callback({ (response:JSON, responseCode:Int) in
                callback(result: responseCode == HTTPCode.OK)
            })
            .execute()
    }
    
    static func getBrands(partialBrand:String, callback:(matchingBrands:[String], matchingBrandsDir:[String]) -> Void) -> Void{
        
        APIRequest(httpMethod: Alamofire.Method.GET, url: "watches/brands/"+partialBrand)
            .callback({ (response:JSON, responseCode:Int) in
                
                let matchingBrands:[String] = response.arrayValue.map{$0["name"].string!}
                let matchingBrandsDir:[String] = response.arrayValue.map{$0["models"].string!}
                callback(matchingBrands: matchingBrands, matchingBrandsDir:matchingBrandsDir);
            })
            .execute();
    }
    
    static func getModels(brand:String, partialModel:String, callback: (matchingModels:[String]) -> Void) -> Void {
        
        APIRequest(httpMethod: Alamofire.Method.GET, url: "watches/models/"+brand+"/"+partialModel)
            .callback({ (response:JSON, responseCode:Int) in
                
                let matchingModels:[String] = response.arrayValue.map{$0.string!}
                
                print(matchingModels);
                callback(matchingModels: matchingModels);
            })
            .execute();
    }
    
    static func saveWatch(watch:Watch, callback: (success:Bool, externalId:Int) -> Void) -> Void {
        
        APIRequest(httpMethod: Alamofire.Method.POST, url: "watches")
            .addParameter("brand", value: watch.brand)
            .addParameter("name", value: watch.model)
            .addParameter("yearOfBuy", value: watch.yearOfPurchase)
            .addParameter("serial", value: watch.serial)
            .addParameter("caliber", value: watch.caliber)
            .callback({ (response:JSON, responseCode:Int) in
                
                var id:Int = -random();
                
                if let externalId = response["id"].int{
                    id = externalId;
                }
                
                callback(success: responseCode == HTTPCode.OK, externalId: id);
            })
            .execute();
    }
    
    static func deleteWatch(watch:Watch, callback:(success:Bool) -> Void) -> Void {
        APIRequest(httpMethod: Alamofire.Method.DELETE, url: "watches")
            .addParameter("watchId", value: String(watch.id))
            .callback({ (response:JSON, responseCode:Int) in
                callback(success: responseCode == HTTPCode.OK)
            })
            .execute()
    }
    
    static func updateWatch(watch:Watch, callback:(success:Bool) -> Void) -> Void {
        
        APIRequest(httpMethod: Alamofire.Method.PUT, url: "watches")
            .addParameter("brand", value: watch.brand)
            .addParameter("name", value: watch.model)
            .addParameter("yearOfBuy", value: watch.yearOfPurchase)
            .addParameter("serial", value: watch.serial)
            .addParameter("caliber", value: watch.caliber)
            .addParameter("id", value: String(watch.id))
            .callback({ (response:JSON, responseCode:Int) in
                callback(success: responseCode == HTTPCode.OK)
            })
            .execute()
    }
    
    static func newMeasure(watchId:Int, userTime:Double, referenceTime:Double, callback:(success:Bool, externalId:Int) -> Void) -> Void {
        APIRequest(httpMethod: Alamofire.Method.POST, url: "measures")
            .addParameter("watchId", value: String(watchId))
            .addParameter("referenceTime", value: String(referenceTime))
            .addParameter("userTime", value: String(userTime))
            .callback({ (response:JSON, responseCode:Int) in
                
                var id:Int = -random();
                
                if let externalId = response["measureId"].int{
                    id = externalId;
                }
                
                callback(success: responseCode == HTTPCode.OK, externalId: id)
            })
            .execute()
    }
    
    
    static func newAccuracyMeasure(measureId:Int, userTime:Double, referenceTime:Double, callback:(success:Bool) -> Void) -> Void {
        APIRequest(httpMethod: Alamofire.Method.PUT, url: "measures")
            .addParameter("measureId", value: String(measureId))
            .addParameter("referenceTime", value: String(referenceTime))
            .addParameter("userTime", value: String(userTime))
            .callback({ (response:JSON, responseCode:Int) in
                
                callback(success: responseCode == HTTPCode.OK)
            })
            .execute()
    }
    
    static func getWatches(callback:(watches:[Watch]) -> Void) -> Void {
        
        APIRequest(httpMethod: Alamofire.Method.GET, url: "watches")
            .callback({ (response:JSON, responseCode:Int) in
                
                var watches:[Watch] = [];
                
                for rawWatch in response.arrayValue{
                    
                    var measures:[Measure] = [];
                    
                    for rawMeasure in rawWatch["measures"].arrayValue{
                        

                        measures.append(Measure(
                            id: rawMeasure["id"].int!,
                            measureUserTime: rawMeasure["measureUserTime"].double!,
                            measureReferenceTime: rawMeasure["measureReferenceTime"].double!,
                            accuracyTime: rawMeasure["accuracyUserTime"].double!,
                            accuracyReferenceTime: rawMeasure["accuracyReferenceTime"].double!,
                            accuracy: rawMeasure["accuracy"].float!,
                            accuracyAge: rawMeasure["accuracyAge"].float!,
                            status: rawMeasure["statusId"].float!))
                        
                    }
                    
                    watches.append(Watch(id:rawWatch["watchId"].int!,
                        brand: rawWatch["brand"].string!,
                        model: rawWatch["name"].string!,
                        yearOfPurchase: String(rawWatch["yearOfBuy"].int!),
                        serial: rawWatch["serial"].string!,
                        caliber: rawWatch["caliber"].string!,
                        historySize: rawWatch["historySize"].int!,
                        measures:measures)
                    )
                }
                
                callback(watches: watches);
                
            })
            .execute();
    }
    
}