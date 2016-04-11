//
//  RegisterViewController.swift
//  Toolwatch
//
//  Created by math on 2016-04-08.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class RegisterViewController: UITableViewWithHeader {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    private var country:String = ""
    
    /**
     @IBOutlet weak var registerButton: UIButton!
     Override didLaod so we can create the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.createHeader("register-header-img", title: "", subtitle: "Feel the form below to create an account",
            btnArt: "back-btn", btnAction: "backBtnClicked:", rightButton: false)
        
        registerButton.layer.cornerRadius = 5;
        
        //http://stackoverflow.com/a/27491026
        let locale: NSLocale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        let countryCode = locale.objectForKey(NSLocaleCountryCode) as! String
        let country: String? = locale.displayNameForKey(NSLocaleCountryCode, value: countryCode)
        
        // According to the docs, "Not all locale property keys
        // have values with display name values" (thus why the
        // "country" variable's an optional). But if this one
        // does have a display name value, you can print it like so.
        if let foundCountry = country {
            self.country = foundCountry;
            print(self.country);
        }
        
        //Set default values for optional variables
//        email.text = "";
//        confirmEmail.text = "";
//        password.text = "";
//        confirmPassword.text = "";
//        name.text = "";
//        firstname.text = "";
        
    }
    
    @IBAction func register(sender: AnyObject) {
        
        if(email.text != confirmEmail.text || isValidEmail(email.text!) == false || password.text != confirmPassword.text || password.text?.characters.count < 6){
            let alertController = UIAlertController(
                title: "Whoops!",
                message:"Email must be valid and password be at least 6 characters long",
                preferredStyle: UIAlertControllerStyle.Alert
            );
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil));
            self.presentViewController(alertController, animated: true, completion: nil);
            
        }else{
            
            API.registerEmail(email.text!, password: password.text!, name: name.text!, firstName: firstname.text!, country: country, callback: {
                
                (result:Bool) in
                if(result){
                    
                    let addWatchView =  self.storyboard?.instantiateViewControllerWithIdentifier("DashboardID") as! UITabBarController
                    self.presentViewController(addWatchView, animated: true, completion: nil)
                    
                }else{
                    let alertController = UIAlertController(
                        title: "Whoops!",
                        message:"This email is already taken. Retry with another email or visit https://toolwatch.io to reset your password.",
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
    
    /**
     http://stackoverflow.com/a/25471164
     
     - parameter testStr: <#testStr description#>
     
     - returns: <#return value description#>
     */
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    /**
     Defines custom height for each rows
     
     - parameter tableView:
     - parameter indexPath:
     
     - returns: the heigh of a row
     */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //Even number are labels
        if(indexPath.item % 2 == 0 && indexPath.item != 13){
            return self.view.frame.size.height * (20/5/100)
            
            //Odd numbers are input
        }else if(indexPath.item != 13){
            return self.view.frame.size.height * (40/5/100)
            
            //The validate button
        }else{
            return self.view.frame.size.height * 0.2
        }
    }
    
    /**
     Handle click on the back button
     
     - parameter sender: The Back button
     */
    func backBtnClicked(sender:UIButton!){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    

}
