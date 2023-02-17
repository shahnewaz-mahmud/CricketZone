//
//  PlayerCareerTableViewCell.swift
//  CricketZone
//
//  Created by Admin on 17/2/23.
//

import UIKit

class PlayerCareerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 25
        cellBackground.dropShadow()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
