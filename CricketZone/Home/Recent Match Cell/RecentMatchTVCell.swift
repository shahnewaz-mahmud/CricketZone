//
//  RecentMatchTVCell.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import UIKit

class RecentMatchTVCell: UITableViewCell {
    
    @IBOutlet weak var matchBackground: UIView!
    @IBOutlet weak var league: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var team1Flag: UIImageView!
    @IBOutlet weak var team1Code: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team1Over: UILabel!
    @IBOutlet weak var matchResult: UILabel!
    @IBOutlet weak var team2Flag: UIImageView!
    @IBOutlet weak var team2Code: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var team2Over: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        team1Flag.layer.cornerRadius = 10
        team2Flag.layer.cornerRadius = 10
        matchBackground.layer.cornerRadius = 20
        matchBackground.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMatch(matchInfo: Match) {
        league.text = matchInfo.type
        team1Code.text = matchInfo.localteam?.code
        team2Code.text = matchInfo.visitorteam?.code
        let dateTime = Shared().getReadableDateTime(data: matchInfo.starting_at ?? "")
        matchDate.text = dateTime.1 + ", " + dateTime.0
        team1Score.text = String(matchInfo.runs[0].score ?? 0)+"/"
        team1Over.text = "("+String(matchInfo.runs[0].overs ?? 0)+")"

    }
    
}
