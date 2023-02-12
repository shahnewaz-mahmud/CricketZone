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
    
    @IBOutlet weak var countDownText: UILabel!
    
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
        team1Flag.sd_setImage(
            with: URL(string: matchInfo.localteam?.image_path ?? ""),
            placeholderImage: UIImage(named: "f1")
        )
        team2Flag.sd_setImage(
            with: URL(string: matchInfo.visitorteam?.image_path ?? ""),
            placeholderImage: UIImage(named: "f1")
        )
        
        if matchInfo.runs.isEmpty {
            liveLabelImg.isHidden = true
            team1Score.isHidden = true
            team2Score.isHidden = true
            team1Over.isHidden = true
            team2Over.isHidden = true
            
            let currentTime = Date()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
            let matchDate = dateFormatter.date(from: matchInfo.starting_at ?? "")
            
            guard let matchDate = matchDate else {
                return
            }
            
            let timeInterval = matchDate - currentTime
            
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day, .hour, .minute, .second]
            formatter.zeroFormattingBehavior = .dropAll
            formatter.unitsStyle = .abbreviated
            formatter.maximumUnitCount = 4

            let formattedDuration = formatter.string(from: timeInterval)
            
            countDownText.text = formattedDuration
            let dateTime = Shared().getReadableDateTime(data: matchInfo.starting_at ?? "")
            matchTime.text = dateTime.1+", "+dateTime.0
        }
        
 
    }

}
