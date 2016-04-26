//
//  LoginViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-25.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit
class LoginViewController: UITableViewWithHeader{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.createHeader("header-dashboard", title: "", subtitle: "THE MOST CONVENIENT WAY TO MEASURE THE \n  ACCURACY OF YOUR MECHANICAL WATCH");
    }
    
    /**
     Defines custom height for each rows
     
     - parameter tableView:
     - parameter indexPath:
     
     - returns: the heigh of a row
     */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //30% is taken by the header
        //25% for the email/pw
        //20% for the login button
        //20% for the register
        
        //5% border from the header
        if(indexPath.item == 1){
            return self.view.frame.size.height * (5/100);
        }else if (indexPath.item < 5){
            
            if(indexPath.item % 2 == 1){
                return self.view.frame.size.height * (4/100);
            }else {
                return self.view.frame.size.height * (8/100);
            }
        }else if (indexPath.item == 5){
            return self.view.frame.size.height * (15/100)
        }else{
            return self.view.frame.size.height * (10/100)
        }
        
    }


    @IBAction func loginPressed(sender: AnyObject) {
        
        API.login(email.text!, password: password.text!, callback: {
           
            (result:Bool) in
            if(result){
                
                API.getWatches({
                    (watches:[Watch]) in
                    
                    let dashboard =  self.storyboard?.instantiateViewControllerWithIdentifier("DashboardID") as! UITabBarController
                    WatchesViewController.watches = watches;
                    self.presentViewController(dashboard, animated: true, completion: nil)
                    
                });
                
            }else{
                let alertController = UIAlertController(
                    title: "Whoops!",
                    message:"Email/Password combination is wrong. Retry or visit https://toolwatch.io to reset your password",
                    preferredStyle: UIAlertControllerStyle.Alert
                );
                self.activityIndicator.stopAnimating()
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil));
                self.presentViewController(alertController, animated: true, completion: nil);
            }
        });
     
        self.activityIndicator.startAnimating()
        
    }
    
}
