//
//  Game.swift
//  Scheduler
//
//  Created by Micheal Willard on 11/4/16.
//  Copyright © 2016 Micheal Willard. All rights reserved.
//

import UIKit

class Game {
    
    // MARK:  Properties
    
    // Remember not to send id on POST
    var game_id: Int
    var opp_name: String
    var location: String
    var date: String
    var time: String
    var attending: [Int]
    var not_attending: [Int]
    
    // MARK: Initialization
    init?(game_id: Int, opp_name: String, location: String, date: String, time: String, attending: [Int], not_attending: [Int]) {
        self.game_id = game_id
        self.opp_name = opp_name
        self.location = location
        self.date = date
        self.time = time
        self.attending = attending
        self.not_attending = not_attending
        
        if opp_name.isEmpty || location.isEmpty || date.isEmpty || time.isEmpty {
            return nil
        }
    }
}
