//
//  LiveMatchCVCell.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import UIKit

class LiveMatchCVCell: UICollectionViewCell {
    
    @IBOutlet weak var league: UILabel!
    @IBOutlet weak var matchBackgroundView: UIView!
    @IBOutlet weak var team1Flag: UIImageView!
    @IBOutlet weak var team1Code: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team1Over: UILabel!
    @IBOutlet weak var team2Flag: UIImageView!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var team2Code: UILabel!
    @IBOutlet weak var team2Over: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        matchBackgroundView.layer.cornerRadius = 20
        team2Flag.layer.cornerRadius = 9
        team1Flag.layer.cornerRadius = 9
        matchBackgroundView.dropShadow()
    
    }

}
