//
//  Watch.swift
//  Toolwatch
//
//  Created by math on 2016-02-10.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation

struct Watch {
    
    var id: Int
    var brand: String
    var model: String?
    var yearOfPurchase: String?
    var serial: String?
    var caliber: String?
    var statusId: Float
    var accuracy: Float
    
    init(id: Int, brand: String, model: String?, yearOfPurchase: String?, serial: String?,
        caliber: String?, statusId: Float, accuracy: Float){
        
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
