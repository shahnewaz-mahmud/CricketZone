//
//  PlayerInfoTableViewCell.swift
//  CricketZone
//
//  Created by Admin on 17/2/23.
//

import UIKit

class PlayerInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var card1Background: UIView!
    @IBOutlet weak var card2Background: UIView!
    @IBOutlet weak var card1Value: UILabel!
    @IBOutlet weak var card1Label: UILabel!
    
    
    @IBOutlet weak var card2value: UILabel!
    
    @IBOutlet weak var card2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        card1Background.layer.cornerRadius = 10
        card1Background.dropShadow()
        
        card2Background.layer.cornerRadius = 10
        card2Background.dropShadow()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
