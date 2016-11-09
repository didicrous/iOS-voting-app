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

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    var candidates = [NSManagedObject]()
    var delegate: DataModelProtocol?
    
    override func viewWillAppear(animated: Bool) {
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
    
    override func viewDidLoad() {
        definesPresentationContext = true
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.catchAddCandNotification), name: "addCandNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.catchVoteNotification), name: "addVoteNotification", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func addCandidate(fName:String, lName:String, stateLabel: String, polParty:String, votes:Int)
    {
        
        NSNotificationCenter.defaultCenter().postNotificationName("addCandNotification", object: nil, userInfo: ["firstName": fName, "lastName": lName, "state": stateLabel, "polParty": polParty, "votes": votes])
        
    }
    
    func catchAddCandNotification(notification:NSNotification) -> Void{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Candidate", inManagedObjectContext: managedContext)
        let candidate = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        let userInfo = notification.userInfo
        let fName = userInfo!["firstName"]
        print(fName)
        let lName = userInfo!["lastName"]
        print(lName)
        let stateLabel = userInfo!["state"]
        print(stateLabel)
        let polParty = userInfo!["polParty"]
        
        candidate.setValue(fName, forKey: "firstName")
        candidate.setValue(lName, forKey: "lastName")
        candidate.setValue(stateLabel, forKey: "state")
        candidate.setValue(polParty, forKey: "polParty")
        candidate.setValue(0, forKey: "votes")
        
        do {
            try managedContext.save()
            candidates.append(candidate)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        let notification = UILocalNotification()
        // set message to appear on the notification
        notification.alertBody = "Candidate saved!"
        
        notification.timeZone = NSTimeZone.defaultTimeZone()
        
        // set the notification
        //    UIApplication.sharedApplication() is our app
        //    schedule the notification with that app
        UIApplication.sharedApplication()
            .scheduleLocalNotification(notification)
        
    }
    
    func catchVoteNotification(notification:NSNotification) -> Void{
        let userInfo = notification.userInfo
        let row = userInfo!["row"] as! Int
        let candidate = candidates[row] as! NSManagedObject
        var votes = candidates[row].valueForKey("votes") as! Int
        votes = Int(votes + 1)
        candidate.setValue(Int(votes), forKey: "votes")
        
        let notification = UILocalNotification()
        // set message to appear on the notification
        notification.alertBody = "Vote saved!"
        
        notification.timeZone = NSTimeZone.defaultTimeZone()
        
        // set the notification
        //    UIApplication.sharedApplication() is our app
        //    schedule the notification with that app
        UIApplication.sharedApplication()
            .scheduleLocalNotification(notification)
        
    }
    
    @IBAction func voteButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("popoverSegue", sender: self)
    }
    
    
    @IBAction func showVotesButtonPressed(sender: AnyObject){
        self.performSegueWithIdentifier("popoverSegue2", sender: self)
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue,
                                  sender: AnyObject?) {
        if segue.identifier == "popoverSegue" {
            let vc = segue.destinationViewController as!
            UIViewController
            vc.preferredContentSize = CGSizeMake(250, 200)
            let controller = vc.popoverPresentationController
            if controller != nil {
                controller?.delegate = self
            }
            
        }
        
        if segue.identifier == "popoverSegue2" {
            let vc = segue.destinationViewController as!
            UIViewController
            vc.preferredContentSize = CGSizeMake(250, 200)
            let controller = vc.popoverPresentationController
            if controller != nil {
                controller?.delegate = self
            }
            
        }
    }
    
    @IBAction func clearDataButton(sender: AnyObject) {
        deleteAllData()
    }
    func deleteAllData()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Candidate")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in candidates error")
        }
    }
    
    
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

