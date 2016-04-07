//
//  LoginViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-25.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func loginPressed(sender: AnyObject) {
        
        APIRequest(httpMethod: Alamofire.Method.PUT, url: "users", model: SyncronizableModel())
            .addParameter("email", value: email.text!)
            .addParameter("password", value: password.text!)
            .callback(self.navigate)
            .execute();

    }
    
    private func navigate(model:SyncronizableModel, response:Int) -> Void {
        if(response == HTTPCode.OK){
            
        }else{
            let alertController = UIAlertController(
                title: "Whoops!",
                message:"Email/Password combination is wrong. Retry or visit https://toolwatch.io to reset your password",
                preferredStyle: UIAlertControllerStyle.Alert
            );
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil));
            self.presentViewController(alertController, animated: true, completion: nil);
        }
    }
    
}
