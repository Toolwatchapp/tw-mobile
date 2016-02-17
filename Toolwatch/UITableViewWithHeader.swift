//
//  UITableViewWithHeader.swift
//  Toolwatch
//
//  Created by math on 2016-02-17.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class UITableViewWithHeader: UITableViewController {
    
    func createHeader(headerArt: String, title: String, subtitle: String){
        //Frame
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 200)
        let headerView = UIView(frame: frame);
        
        //Background image
        let headerImageView = UIImageView(frame: frame)
        let image: UIImage = UIImage(named: headerArt)!
        headerImageView.image = image
        
        //Add and send to back the background view
        headerView.addSubview(headerImageView);
        headerView.sendSubviewToBack(headerImageView);
        
        headerView.addSubview(self.createLabel(title, postion: (headerImageView.frame.size.height/2)-20, font: "Avenir-Book",  size: 35))
        headerView.addSubview(self.createLabel(subtitle, postion: (headerImageView.frame.size.height/2)+5, font: "Avenir-Light",  size: 15))
        
        self.tableView.tableHeaderView = headerView
        
    }
    
    private func createLabel(labelText: String, postion: CGFloat, font : String, size: Int) -> UILabel {
        
        let label = UILabel(frame: CGRectMake(0, postion, self.view.frame.size.width, 100))
        label.textAlignment = NSTextAlignment.Center
        label.text = labelText
        label.textColor = 	UIColor.whiteColor()
        label.shadowColor = UIColor.whiteColor()
        label.font = UIFont(name: font, size: CGFloat(size))
        return label
    }

}
