//
//  LoginViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-25.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5;
    }


    @IBAction func loginPressed(sender: AnyObject) {
        
        API.login(email.text!, password: password.text!, callback: {
           
            (result:Bool) in
            if(result){
                
                let addWatchView =  self.storyboard?.instantiateViewControllerWithIdentifier("DashboardID") as! UITabBarController
                self.presentViewController(addWatchView, animated: true, completion: nil)
                
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
