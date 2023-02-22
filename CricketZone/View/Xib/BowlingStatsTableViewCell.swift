//
//  BowlingStatsTableViewCell.swift
//  CricketZone
//
//  Created by Admin on 22/2/23.
//

import UIKit

class BowlingStatsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    
    @IBOutlet weak var totalMatch: UILabel!
    
    @IBOutlet weak var totalOvers: UILabel!
    
    
    @IBOutlet weak var ecoRate: UILabel!
    
    @IBOutlet weak var totalRuns: UILabel!
    
    
    @IBOutlet weak var totalWickets: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 25
        
        cellBackground.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
