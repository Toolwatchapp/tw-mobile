//
//  WatchCell.swift
//  Toolwatch
//
//  Created by math on 2016-02-12.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class WatchCell: UITableViewCell {
    
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    
    var watch: Watch! {
        didSet {
            watchLabel.text = watch.brand + " " + watch.model!
            accuracyLabel.text = String(watch.accuracy) + " seconds per day"
        }
    }

}
