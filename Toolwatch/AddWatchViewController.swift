//
//  AddWatchViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-19.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

/// Controller for the add watch view
class AddWatchViewController: UITableViewWithHeader {
    
    @IBOutlet weak var brand: AutoCompleteTextField!
    @IBOutlet weak var model: AutoCompleteTextField!
    @IBOutlet weak var caliber: UITextField!
    @IBOutlet weak var yearOfPurchase: UITextField!
    @IBOutlet weak var serial: UITextField!
    @IBOutlet weak var addWatchButton: UIButton!
    @IBOutlet weak var brandCell: UITableViewCell!
    @IBOutlet weak var modelCell: UITableViewCell!
    var watch: Watch!
    private var matchingBrandsDir:[String] = [];
    private var selectedBrandDirIndex:Int = -1;
    
    /**
     Override didLaod so we can create the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWatchButton.layer.cornerRadius = 5;
        
        super.createHeader("header-watch", title: "", subtitle: "Add a watch",
            btnArt: "back-btn", btnAction: "backBtnClicked:", rightButton: false)
        
        initAutocompleteLabel(brand)
        initAutocompleteLabel(model)
        
        brand.onTextChange = {text in
            if !text.isEmpty{
                
                self.selectedBrandDirIndex = -1
                
                API.getBrands(text, callback: {
                    
                    (matchingBrands:[String], matchingBrandsDir:[String]) in
                    self.brand.autoCompleteStrings = matchingBrands
                    self.matchingBrandsDir = matchingBrandsDir;
                    self.brandCell.frame.size.height = self.view.frame.size.height * (40/5/100) + CGFloat(35 * matchingBrands.count)
                })
                
            }
        }
        
        brand.onSelect = {text, indexpath in
            self.selectedBrandDirIndex = indexpath.row
            self.brandCell.frame.size.height = self.view.frame.size.height * (40/5/100)
        }
        
        model.onTextChange = {text in
            if !text.isEmpty && self.selectedBrandDirIndex != -1{
                
                API.getModels(self.matchingBrandsDir[self.selectedBrandDirIndex], partialModel: text, callback: {
                    (matchingModels:[String]) in
                    self.model.autoCompleteStrings = matchingModels
                    self.modelCell.frame.size.height = self.view.frame.size.height * (40/5/100) + CGFloat(35 * matchingModels.count)
                })
            }
        }
        
        model.onSelect = {text, indexpath in
            self.modelCell.frame.size.height = self.view.frame.size.height * (40/5/100)
        }

    }
    
    /**
     Initialisation of Autocomplete button
     
     - parameter label: <#label description#>
     
     - returns: <#return value description#>
     */
    private func initAutocompleteLabel(label:AutoCompleteTextField){
        label.autoCompleteCellHeight = 35.0
        label.maximumAutoCompleteCount = 20
        label.hidesWhenSelected = true
        label.hidesWhenEmpty = true
        label.enableAttributedText = true
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.blackColor()
        attributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        label.autoCompleteAttributes = attributes
    }
    
    /**
     Defines custom height for each rows
     
     - parameter tableView:
     - parameter indexPath:
     
     - returns: the heigh of a row
     */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //We used 30% of the frame for the header
        //We need 10% for the validate button
        //The 60% remaining are 40% for inputs and 20% for labels
        
        //Even number are labels
        if(indexPath.item % 2 == 0 && indexPath.item != 10){
            //The heigh of the screen * (20% / 5 labels / 100)
            return self.view.frame.size.height * (20/5/100)
       
        //Odd numbers are input
        }else if(indexPath.item != 10){
            //The heigh of the screen * (40% / 5 inputs / 100)
            return self.view.frame.size.height * (40/5/100)
            
        //The validate button
        }else{
            return self.view.frame.size.height * 0.1
        }
    }
    
    /**
     Handle click on the back button
     
     - parameter sender: The Back button
     */
    func backBtnClicked(sender:UIButton!){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    /**
     When we are about to leave, create a new watch with the form content
     
     - parameter segue
     - parameter sender
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveWatch" {
            watch = Watch(brand: brand.text!.trim(), model: model.text!.trim(), yearOfPurchase: yearOfPurchase.text!, serial: serial.text!, caliber: caliber.text!)
            
        }
    }

}
