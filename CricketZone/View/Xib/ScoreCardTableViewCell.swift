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
    
    @IBOutlet weak var run: UILabel!
    
    @IBOutlet weak var ball: UILabel!
    
    @IBOutlet weak var fours: UILabel!
    
    @IBOutlet weak var sixes: UILabel!
    
    @IBOutlet weak var strikeRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
