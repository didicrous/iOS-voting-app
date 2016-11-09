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

class Candidate{
    
    var firstName:String = ""
    var lastName:String = ""
    var state:String = ""
    var polParty:String = ""
    var votes:Int = 0
    
    init(firstName:String, lastName:String, state:String, polParty:String, votes:Int)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.state = state
        self.polParty = polParty
        self.votes = votes
    }
    
    
    
}