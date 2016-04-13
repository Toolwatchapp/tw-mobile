//
//  WatchesViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-10.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

/// Dashboard controller
class WatchesViewController: UITableViewWithHeader {
    
    static var watches:[Watch] = [Watch]()
    var selectedCell: WatchCell!
    
    static var needRefresh:Bool = false
    static var pendingRequests:[APIRequest] = []

    /**
     Override the didLoad to load the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.createHeader("header-dashboard", title: "Measures", subtitle: "ADD OR START A NEW MEASURE",
            btnArt: "add-btn", btnAction: "addWatch:", rightButton: true)
        
        tabBarItem = UITabBarItem(title: "Measures", image: UIImage(named: "measure-image"), tag: 0)
        
        
//        if let savedWatches = loadWatches() {
//            print("loading")
//            watches = savedWatches
//        } else {
//            // Load the sample data.
//            watches = watchesData
//        }
    }
    
    /**
     Will refresh the list if WatchesViewController.needRefresh = true
     
     - parameter animated: animated description
     */
    override func viewDidAppear(animated: Bool) {
        
        if(WatchesViewController.needRefresh){
            self.tableView.reloadRowsAtIndexPaths([self.selectedCell.indexPath], withRowAnimation: .Automatic)
            self.saveWatches()
            WatchesViewController.needRefresh = false
        }
        
        super.viewDidAppear(animated)
    }
    
    /**
     Present the new watch controller
     
     - parameter sender: Add Watch button
     */
    func addWatch(sender:UIButton!)
    {
        let addWatchView =  self.storyboard?.instantiateViewControllerWithIdentifier("AddWatchId") as! UINavigationController
        self.presentViewController(addWatchView, animated: true, completion: nil)
    }

    /**
     Override the number of section to be 1
     
     - parameter tableView: watches table view
     
     - returns: 1
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    /**
     Override the number of cells
     
     - parameter tableView: watches table view
     - parameter section:   sections
     
     - returns: amont of watch in watches
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return WatchesViewController.watches.count
    }
    
    /**
     Creates the table view with the cells
     
     - parameter tableView: The watch table view
     - parameter indexPath
     
     - returns: A populated table view
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WatchCell", forIndexPath: indexPath)
            as! WatchCell
        
        let watch = WatchesViewController.watches[indexPath.row] as Watch
        cell.watch = watch
        cell.detailCallback = self.detailCallback;
        cell.measureCallback = self.measureCallback;
        cell.indexPath = indexPath
        
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = UIColor(red: CGFloat(243) / 255, green: CGFloat(243) / 255, blue: CGFloat(244) / 255, alpha: CGFloat(1)).CGColor
        border.frame = CGRect(x: 0, y: cell.frame.size.height - width, width:  cell.frame.size.width, height: cell.frame.size.height)
        
        border.borderWidth = width
        cell.layer.addSublayer(border)
        cell.layer.masksToBounds = true
        
        
        return cell
    }
    
    /**
     Defines custom height for each rows
     
     - parameter tableView:
     - parameter indexPath:
     
     - returns: the heigh of a row
     */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return CGFloat(110)
    }
    
    /**
     Displays the MeasureController
     
     - parameter watchCell: The clicked cell
     */
    func measureCallback(watchCell: WatchCell){
        
        self.selectedCell = watchCell;
        
        let addMeasureView =  self.storyboard?.instantiateViewControllerWithIdentifier("NewMeasureID") as! UINavigationController
        let addMeasureTableView = addMeasureView.topViewController as! MeasureViewController
        addMeasureTableView.watch = self.selectedCell.watch
        self.presentViewController(addMeasureView, animated: true, completion: nil)
    }
    
    /**
     Displays the edit watch controller
     
     - parameter watchCell: the clicked cell
     */
    func detailCallback(watchCell: WatchCell){
        self.selectedCell = watchCell;
        
        let editWatchView =  self.storyboard?.instantiateViewControllerWithIdentifier("EditWatchId") as! UINavigationController
        let editWatchTableView = editWatchView.topViewController as! EditWatchViewController
        editWatchTableView.watch = self.selectedCell.watch
        self.presentViewController(editWatchView, animated: true, completion: nil)
    }
    
    /**
     Add a new watch to the list
     
     - parameter segue: the triggered segue
     */
    @IBAction func saveWatch(segue:UIStoryboardSegue) {
        
        if let addWatchViewController = segue.sourceViewController as? AddWatchViewController {
            
            //Add the new watch to the watches array
            if let watch = addWatchViewController.watch {
                
                API.saveWatch(watch, callback: {(success:Bool, externalId:Int) in
                
                    WatchesViewController.watches[WatchesViewController.watches.indexOf(watch)!].id = externalId
                    self.saveWatches();
                
                });
                
                WatchesViewController.watches.append(watch)
                
                //update the tableView
                let indexPath = NSIndexPath(forRow: WatchesViewController.watches.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    /**
     When we leave the result screen
     
     - parameter segue: the triggered segue
     */
    @IBAction func measureComplete(segue:UIStoryboardSegue) {
        
        self.tableView.reloadRowsAtIndexPaths([self.selectedCell.indexPath], withRowAnimation: .Automatic)
        self.saveWatches()
    }
    
    /**
     Delete a watch
     
     - parameter segue: the triggered segue
     */
    @IBAction func deleteWatch(segue:UIStoryboardSegue) {
        

        
        API.deleteWatch(WatchesViewController.watches[self.selectedCell.indexPath.item], callback: {
            (success:Bool) in
            self.saveWatches();
        });
        
        WatchesViewController.watches.removeAtIndex(self.selectedCell.indexPath.item)
        self.tableView.deleteRowsAtIndexPaths([self.selectedCell.indexPath], withRowAnimation: .Automatic)
 
    }
    
    /**
     Edit a watch to the list
     
     - parameter segue: the triggered segue
     */
    @IBAction func editWatch(segue:UIStoryboardSegue) {
        
        API.updateWatch(WatchesViewController.watches[self.selectedCell.indexPath.item], callback: {
            (success:Bool) in
            self.saveWatches();
        });

        self.tableView.reloadRowsAtIndexPaths([self.selectedCell.indexPath], withRowAnimation: .Automatic)
        self.saveWatches()
    }
    
    // MARK: NSCoding
    
    /**
    Persists watch
    */
    func saveWatches(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(WatchesViewController.watches, toFile: Watch.ArchiveURL.path!)
        print("Saving...")
        if !isSuccessfulSave {
            print("Failed to save watches...")
        }
    }
    
    /**
     Loads watches
     
     - returns: an array of watch
     */
    func loadWatches() -> [Watch]? {
        
        
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Watch.ArchiveURL.path!) as? [Watch]
    }

}
