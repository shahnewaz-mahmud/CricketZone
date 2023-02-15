//
//  ScoreCardTableViewCell.swift
//  CricketZone
//
//  Created by BJIT on 2/15/23.
//

import UIKit

class ScoreCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var outInfo: UILabel!
    
    @IBOutlet weak var score1: UILabel!
    
    @IBOutlet weak var score2: UILabel!
    
    @IBOutlet weak var score3: UILabel!
    
    @IBOutlet weak var score4: UILabel!
    
    @IBOutlet weak var score5: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
