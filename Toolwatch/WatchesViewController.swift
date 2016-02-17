//
//  WatchesViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-10.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class WatchesViewController: UITableViewController {
    
    var watches:[Watch] = watchesData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createHeader()
       
    }
    
    private func createHeader(){
        //Frame
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 200)
        let headerView = UIView(frame: frame);
        
        //Background image
        let headerImageView = UIImageView(frame: frame)
        let image: UIImage = UIImage(named: "header-art-image")!
        headerImageView.image = image
        
        //Add and send to back the background view
        headerView.addSubview(headerImageView);
        headerView.sendSubviewToBack(headerImageView);
        
        headerView.addSubview(self.createLabel("Measures",postion: (headerImageView.frame.size.height/2)-20, font: "Avenir-Book",  size: 35))
        headerView.addSubview(self.createLabel("Add or start new measures",postion: (headerImageView.frame.size.height/2)+5, font: "Avenir-Light",  size: 15))
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
      
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return watches.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WatchCell", forIndexPath: indexPath)
            as! WatchCell
        
        let watch = watches[indexPath.row] as Watch
        cell.watch = watch
        return cell
    }
    
    func test(){
        print("there aa")
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
