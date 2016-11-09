//
//  ViewController.swift
//  CrousDeidre-HW6
//  EID: dc34795
//  Course: CS378
//
//  Created by Deidre Crous on 9/27/16.
//  Copyright © 2016 Deidre Crous. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class candidateViewController: UIViewController, DataModelProtocol {
    
    var candidates = [NSManagedObject]()
    
    @IBOutlet weak var fNameLabel: UITextField!
    
    
    @IBOutlet weak var lNameLabel: UITextField!
    
    
    @IBOutlet weak var stateLabel: UITextField!
    
    
    @IBOutlet weak var candSavedText: UITextField!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var polParty:String = "Democrat"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func demRepubIndex(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            polParty = "Democrat"
        case 1:
            polParty = "Republican"
        default:
            break
        }
        
    }
    
    @IBAction func saveCandInfo(sender: AnyObject) {
        //let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        //dispatch_async(dispatch_get_global_queue(priority,0)){
        let vc:ViewController = ViewController()
        vc.addCandidate(self.fNameLabel.text!, lName: self.lNameLabel.text!, stateLabel: self.stateLabel.text!, polParty: self.polParty, votes: 0)
        //  dispatch_async(dispatch_get_main_queue()){
        self.notify("Data has been saved")
        
        //}
        //}
        
        
    }
    
    func notify(message:String)
    {
        let alertController = UIAlertController(title: "dataSaved", message: message , preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
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