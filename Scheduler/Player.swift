//
//  Player.swift
//  Scheduler
//
//  Created by Micheal Willard on 11/4/16.
//  Copyright © 2016 Micheal Willard. All rights reserved.
//

import UIKit

class Player {
    
    // MARK:  Properties
    
    // Remember not to send id on POST
    var player_id: Int
    var name: String
    var email: String
    var phone: String
    var password: String

    
    // MARK: Initialization
    init?(player_id: Int, name: String, email: String, phone: String, password: String) {
        self.player_id = player_id
        self.name = name
        self.email = email
        self.phone = phone
        self.password = password
        
        if name.isEmpty {
            return nil
        }
    }
}
