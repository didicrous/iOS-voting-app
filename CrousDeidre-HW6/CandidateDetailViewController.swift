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

class CandidateDetailViewController: UIViewController {
    
    var candidates = [NSManagedObject]()
    var candidate:NSManagedObject!
    
    
    @IBOutlet weak var fNameLabel: UILabel!
    
    @IBOutlet weak var lNameLabel: UILabel!
    
    @IBOutlet weak var stateNameLabel: UILabel!
    
    @IBOutlet weak var polPartyLabel: UILabel!
    
    @IBOutlet weak var votesLabel: UILabel!
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fNameLabel.text = String(candidate.valueForKey("firstName")!)
        lNameLabel.text = String(candidate.valueForKey("lastName")!)
        stateNameLabel.text = String(candidate.valueForKey("state")!)
        polPartyLabel.text = String(candidate.valueForKey("polParty")!)
        votesLabel.text = String(candidate.valueForKey("votes")!)
        
        // Do any additional setup after loading the view.
    }
    
    
}
