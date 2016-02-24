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
    
    var watches:[Watch] = [Watch]()
    var selectedCell: WatchCell!

    /**
     Override the didLoad to load the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.createHeader("header-dashboard", title: "Measures", subtitle: "Add or start a measure",
            btnArt: "add-btn", btnAction: "addWatch:", rightButton: true)
        
        if let savedWatches = loadWatches() {
            print("loading")
            watches = savedWatches
        } else {
            // Load the sample data.
            watches = watchesData
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if((selectedCell) != nil){
            self.tableView.reloadRowsAtIndexPaths([self.selectedCell.indexPath], withRowAnimation: .Automatic)
            self.selectedCell = nil
            self.saveWatches();
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
        
        return watches.count
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
        
        let watch = watches[indexPath.row] as Watch
        cell.watch = watch
        cell.detailCallback = self.detailCallback;
        cell.measureCallback = self.measureCallback;
        cell.indexPath = indexPath
        return cell
    }
    
    func measureCallback(watchCell: WatchCell){
        
        self.selectedCell = watchCell;
        
        let addMeasureView =  self.storyboard?.instantiateViewControllerWithIdentifier("NewMeasureID") as! UINavigationController
        let addMeasureTableView = addMeasureView.topViewController as! MeasureViewController
        addMeasureTableView.watch = self.selectedCell.watch
        self.presentViewController(addMeasureView, animated: true, completion: nil)
    }
    
    func detailCallback(watchCell: WatchCell){
        print("details")
        print(watchCell.watch.id)
    }
    
    /**
     Add a new watch to the list
     
     - parameter segue: the triggered segue
     */
    @IBAction func saveWatch(segue:UIStoryboardSegue) {
        
        if let addWatchViewController = segue.sourceViewController as? AddWatchViewController {
            
            //Add the new watch to the watches array
            if let watch = addWatchViewController.watch {
                watches.append(watch)
                
                //update the tableView
                let indexPath = NSIndexPath(forRow: watches.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                self.saveWatches()
            }
        }
    }
    
    // MARK: NSCoding
    
    /**
    Persists watch
    */
    func saveWatches(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.watches, toFile: Watch.ArchiveURL.path!)
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
