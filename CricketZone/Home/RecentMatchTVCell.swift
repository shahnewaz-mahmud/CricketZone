//
//  RecentMatchTVCell.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import UIKit

class RecentMatchTVCell: UITableViewCell {
    
    @IBOutlet weak var league: UILabel!
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var team1Flag: UIImageView!
    
    @IBOutlet weak var team1Code: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team1Over: UILabel!
    
    @IBOutlet weak var matchResult: UILabel!
    
    @IBOutlet weak var team2Flag: UIImageView!
    
    @IBOutlet weak var team2Code: UILabel!
    
    
    @IBOutlet weak var team2Score: UILabel!
    
    @IBOutlet weak var team2Over: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
