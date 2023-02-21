//
//  LeagueCollectionViewCell.swift
//  CricketZone
//
//  Created by Shahnewaz on 19/2/23.
//

import UIKit

class LeagueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        leagueImage.layer.cornerRadius = 20
        cellBackground.layer.cornerRadius = 20
        cellBackground.dropShadow()
        // Initialization code
    }

}
