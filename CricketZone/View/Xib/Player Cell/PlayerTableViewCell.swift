//
//  PlayerTableViewCell.swift
//  CricketZone
//
//  Created by Admin on 16/2/23.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellBackground: UIView!
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerPosition: UILabel!
    
    @IBOutlet weak var captainIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 10
        cellBackground.dropShadow()
        playerImage.layer.cornerRadius = playerImage.frame.height/2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
