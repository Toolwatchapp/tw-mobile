//
//  ResultViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-23.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class ResultViewController: UITableViewWithHeader {
    
    @IBOutlet weak var measureButton: UIButton!
    var watch:Watch!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        measureButton.layer.cornerRadius = 5;
        
        super.createHeader("header-result", title: "\n\n\n 2.04", subtitle: "Congratulation \n The accuracy of your Rolex is: \n \n \n \n seconds a day",
             headerHeight: 500)
    }
}
