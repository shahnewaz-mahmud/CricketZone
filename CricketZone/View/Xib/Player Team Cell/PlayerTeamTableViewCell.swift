//
//  PlayerTeamTableViewCell.swift
//  CricketZone
//
//  Created by Admin on 17/2/23.
//

import UIKit

class PlayerTeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var nationalTeam: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 15
        cellBackground.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
