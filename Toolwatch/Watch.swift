//
//  Watch.swift
//  Toolwatch
//
//  Created by math on 2016-02-10.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation

struct Watch {
    
    var id: Int64
    var brand: String
    var model: String?
    var yearOfPurchase: String?
    var serial: String?
    var caliber: String?
    var statusId: Float64
    var accuracy: Float64
    
    init(id: Int64, brand: String, model: String?, yearOfPurchase: String?, serial: String?,
        caliber: String?, statusId: Float64, accuracy: Float64){
        
            self.id = id
            self.brand = brand
            self.model = model
            self.yearOfPurchase = yearOfPurchase
            self.serial = serial
            self.caliber = caliber
            self.statusId = statusId
            self.accuracy = accuracy
    }
    
}
