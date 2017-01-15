//
//  GameTableViewCell.swift
//  Scheduler
//
//  Created by Micheal Willard on 11/5/16.
//  Copyright © 2016 Micheal Willard. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var oppLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
