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
    
    @IBOutlet weak var startsInlabel: UILabel!
    
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        matchBackgroundView.layer.cornerRadius = 20
        team2Flag.layer.cornerRadius = 9
        team1Flag.layer.cornerRadius = 9
        matchBackgroundView.dropShadow()
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.invalidate()
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
        
        if matchInfo.status == "NS" {
            startsInlabel.isHidden = false
            countDownText.isHidden = false
            matchTime.isHidden = false
            
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
            
            var timeInterval = matchDate - currentTime
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                if timeInterval > 0 {
                    timeInterval -= 1
                }
                DispatchQueue.main.async {
                    self.countDownText.text = Shared().getReadableCounter(timeInSeconds: timeInterval)
                }
            }
        
            
            
            
            let dateTime = Shared().getReadableDateTime(data: matchInfo.starting_at ?? "")
            matchTime.text = dateTime.1+", "+dateTime.0
            
        } else {
            liveLabelImg.isHidden = false
            team1Score.isHidden = false
            team2Score.isHidden = false
            team1Over.isHidden = false
            team2Over.isHidden = false
            
            startsInlabel.isHidden = true
            countDownText.isHidden = true
            matchTime.isHidden = true
            
            
            if matchInfo.runs.count == 2 {
                if(matchInfo.localteam_id == matchInfo.runs[0].team_id) {
                    team1Score.text = String(matchInfo.runs[0].score ?? 0)+"/" + String(matchInfo.runs[0].wickets ?? 0)
                    team1Over.text = "("+String(matchInfo.runs[0].overs ?? 0)+")"
                    
                    team2Score.text = String(matchInfo.runs[1].score ?? 0)+"/" + String(matchInfo.runs[1].wickets ?? 0)
                    team2Over.text = "("+String(matchInfo.runs[1].overs ?? 0)+")"
                } else {
                    team1Score.text = String(matchInfo.runs[1].score ?? 0)+"/" + String(matchInfo.runs[1].wickets ?? 0)
                    team1Over.text = "("+String(matchInfo.runs[1].overs ?? 0)+")"
                    
                    team2Score.text = String(matchInfo.runs[0].score ?? 0)+"/" + String(matchInfo.runs[0].wickets ?? 0)
                    team2Over.text = "("+String(matchInfo.runs[0].overs ?? 0)+")"
                }
            } else {
                if(matchInfo.localteam_id == matchInfo.runs[0].team_id) {
                    team1Score.text = String(matchInfo.runs[0].score ?? 0)+"/" + String(matchInfo.runs[0].wickets ?? 0)
                    team1Over.text = "("+String(matchInfo.runs[0].overs ?? 0)+")"
                } else {
                    team2Score.text = String(matchInfo.runs[0].score ?? 0)+"/" + String(matchInfo.runs[0].wickets ?? 0)
                    team2Over.text = "("+String(matchInfo.runs[0].overs ?? 0)+")"
                }
            }
            
        }
        
 
    }

}
