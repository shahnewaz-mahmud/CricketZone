//
//  PlayerStatsTableViewCell.swift
//  CricketZone
//
//  Created by Admin on 22/2/23.
//

import UIKit

class PlayerStatsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellBackground: UIView!
    
    
    @IBOutlet weak var totalMatch: UILabel!
    
    
    @IBOutlet weak var totalRuns: UILabel!
    
    @IBOutlet weak var total50s: UILabel!
    
    
    @IBOutlet weak var total100s: UILabel!
    
    @IBOutlet weak var highestRuns: UILabel!
    
    
    @IBOutlet weak var strikeRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        cellBackground.layer.cornerRadius = 25
        
        cellBackground.dropShadow()

    }
    
}
