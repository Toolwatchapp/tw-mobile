//
//  HelpViewController.swift
//  Toolwatch
//
//  Created by math on 2016-04-12.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class HelpViewController: UITableViewWithHeader {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Help", image: UIImage(named: "help-image"), tag: 1)
    }
    
    
    /**
     Override the didLoad to load the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        super.createHeader("header-image", title: "", subtitle: "")
    }
}
