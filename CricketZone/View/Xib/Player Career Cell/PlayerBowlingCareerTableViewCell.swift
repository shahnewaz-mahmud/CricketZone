//
//  PlayerBowlingCareerTableViewCell.swift
//  CricketZone
//
//  Created by Shahnewaz on 18/2/23.
//

import UIKit

class PlayerBowlingCareerTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIView!
    
    @IBOutlet weak var seasonInfo: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 20
        cellBackground.dropShadow()

    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
