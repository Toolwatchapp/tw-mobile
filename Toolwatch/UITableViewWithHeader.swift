//
//  UITableViewWithHeader.swift
//  Toolwatch
//
//  Created by math on 2016-02-17.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class UITableViewWithHeader: UITableViewController {
    
    /**
     Create a classical header with two titles and no buttons
     
     - parameter headerArt: The image to display (asset wise)
     - parameter title:     The title of the view
     - parameter subtitle:  The subtitle of the view
     */
    func createHeader(headerArt: String, title: String, subtitle: String){
        
        self.tableView.tableHeaderView = self.createHeaderView(headerArt, title: title, subtitle: subtitle)
    }
    
    /**
     Create an header with two titles and one button (left or right)
     
     - parameter headerArt:   Image to display
     - parameter title:       title
     - parameter subtitle:    subtitle
     - parameter btnArt:      image to display for the button
     - parameter btnAction:   action for the button
     - parameter rightButton: is the button to be placed top left or right
     */
    func createHeader(headerArt: String, title: String, subtitle: String, btnArt: String, btnAction: String, rightButton: Bool){
        
        self.createHeader(headerArt, title: title, subtitle: subtitle)
        self.tableView.tableHeaderView?.addSubview(self.createButton(btnArt, action: btnAction, right: rightButton))
    }
    
    /**
     Creates a header with two titles and two buttons (left and right)
     
     - parameter headerArt:      background for the header
     - parameter title:          title
     - parameter subtitle:       subtitle
     - parameter rightBtnArt:    right button background
     - parameter rightBtnAction: right button action
     - parameter leftBtnArt:     left button background
     - parameter leftBtnAction:  left button action
     */
    func createHeader(headerArt: String, title: String, subtitle: String, rightBtnArt: String, rightBtnAction: String, leftBtnArt: String, leftBtnAction: String){
        
        self.createHeader(headerArt, title: title, subtitle: subtitle)
        self.tableView.tableHeaderView?.addSubview(self.createButton(rightBtnArt, action: rightBtnAction, right: true))
        self.tableView.tableHeaderView?.addSubview(self.createButton(leftBtnArt, action: leftBtnAction, right: false))
    }
    
    
    /**
     Create the headerView
     
     - parameter headerArt: Background image
     - parameter title:     Title
     - parameter subtitle:  Subtitle
     
     - returns: an UIView with title, subtitle and background
     */
    private func createHeaderView(headerArt: String, title: String, subtitle: String) -> UIView{
        
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
        
        return headerView

    }
    
    /**
     Creates button to be placed on header
     
     - parameter backgroundImage: background for the button
     - parameter action:          The action to be executed when the button is pressed. 
     Be advise that the daughter class MUST provide the action function
     - parameter right:           is the button to be placed right or left
     
     - returns: an UIButton to be placed on the header
     */
    private func createButton(backgroundImage: String, action: String, right: Bool) -> UIButton {
        
        let image = UIImage(named: backgroundImage) as UIImage?
        let button   = UIButton(type: UIButtonType.Custom) as UIButton
        button.setImage(image, forState: .Normal)
        
        if(right){
            button.frame = CGRectMake(self.view.frame.size.width-40, 20, 30, 30)
        }else{
            button.frame = CGRectMake(10, 20, 30, 30)
        }
        button.addTarget(self, action: Selector(action), forControlEvents: UIControlEvents.TouchUpInside)

        return button;
    }
    
    /**
     Creates label to be used for titles and subtitles
     
     - parameter labelText: text to display
     - parameter postion:   the position frame wise
     - parameter font:      the font to use
     - parameter size:      the font size to use
     
     - returns: A UILabel to be placed on the header
     */
    private func createLabel(labelText: String, postion: CGFloat, font : String, size: Int) -> UILabel {
        
        let label = UILabel(frame: CGRectMake(0, postion, self.view.frame.size.width, 100))
        label.textAlignment = NSTextAlignment.Center
        label.text = labelText
        label.textColor = 	UIColor.whiteColor()
        label.shadowColor = UIColor.whiteColor()
        label.font = UIFont(name: font, size: CGFloat(size))
        label.numberOfLines = 0;
        return label
    }

}
