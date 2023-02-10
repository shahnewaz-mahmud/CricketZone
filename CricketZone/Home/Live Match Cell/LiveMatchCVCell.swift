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
    
    @IBOutlet weak var matchTime: UILabel!
    
    @IBOutlet weak var liveLabelImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        matchBackgroundView.layer.cornerRadius = 20
        team2Flag.layer.cornerRadius = 9
        team1Flag.layer.cornerRadius = 9
        matchBackgroundView.dropShadow()
    
    }
    
    func setMatch(matchInfo: Match) {
        league.text = matchInfo.type
        team1Code.text = matchInfo.localteam?.code
        team2Code.text = matchInfo.visitorteam?.code
        if matchInfo.runs.isEmpty {
            liveLabelImg.isHidden = true
            team1Score.isHidden = true
            team2Score.isHidden = true
            team1Over.isHidden = true
            team2Over.isHidden = true
            
            let dateTime = Shared().getReadableDateTime(data: matchInfo.starting_at ?? "")
            matchTime.text = dateTime.1+", "+dateTime.0
        }
        
 
    }

}
