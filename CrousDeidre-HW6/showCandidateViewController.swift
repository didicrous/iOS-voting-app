//
//  ViewController.swift
//  CrousDeidre-HW6
//  EID: dc34795
//  Course: CS378
//
//  Created by Deidre Crous on 9/27/16.
//  Copyright © 2016 Deidre Crous. All rights reserved.
//

import UIKit
import CoreData

class showCandidateViewController: UITableViewController {
    
    var candidates = [NSManagedObject]()
    var candidate: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated:Bool)
    {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Candidate")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            candidates = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidates.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "candidateCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        candidate = candidates[indexPath.row]
        
        cell.textLabel!.text = String(candidate.valueForKey("firstName")!) + " " + String(candidate.valueForKey("lastName")!)
        cell.detailTextLabel?.text = String(candidate.valueForKey("polParty")!)
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("candDetailSegue", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "candDetailSegue")
        {
            let vc = segue.destinationViewController as! CandidateDetailViewController
            vc.candidate = candidate
            
        }
        
        
    }
    
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
