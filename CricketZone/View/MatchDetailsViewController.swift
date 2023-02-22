//
//  MatchDetailsViewController.swift
//  CricketZone
//
//  Created by Shahnewaz on 11/2/23.
//

import UIKit
import Combine

class MatchDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var team1Flag: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team1Over: UILabel!
    @IBOutlet weak var team2Flag: UIImageView!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var team2Over: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var matchInfoSegment: UIView!
    @IBOutlet weak var scoreCardSegment: UIView!
    @IBOutlet weak var overDetailsSegment: UIView!
    @IBOutlet weak var matchSquadSegment: UIView!
    @IBOutlet weak var liveScoreSegment: UIView!
    
    @IBOutlet weak var matchInfoBtnIcon: UIButton!
    @IBOutlet weak var matchInfoBtnText: UILabel!
    
    @IBOutlet weak var scoreCardBtnIcon: UIButton!
    @IBOutlet weak var scoreCardBtnText: UILabel!
    
    @IBOutlet weak var overDetailsBtnIncon: UIButton!
    @IBOutlet weak var overDetailsBtnText: UILabel!
    
    @IBOutlet weak var matchSquadBtnIcon: UIButton!
    @IBOutlet weak var matchSquadBtnText: UILabel!
    
 
    @IBOutlet weak var liveSegmentBtn: UIButton!
    @IBOutlet weak var liveSegmentBtnText: UILabel!
    
    static var matchDetailsViewModel = MatchDetailsViewModel()
    var selectedMatchId: Int?
    var isLive: Bool?
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        team1Flag.layer.cornerRadius = team1Flag.frame.height/2
        team2Flag.layer.cornerRadius = team2Flag.frame.height/2
        contentView.layer.cornerRadius = 35
        
        MatchDetailsViewController.matchDetailsViewModel.fetchMatchDetails(matchId: selectedMatchId ?? 123, isLive: isLive ?? false)
        setupBinder()
        
        //liveSegmentBtn.isHidden = true
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        MatchDetailsViewController.matchDetailsViewModel.autoRefreshTimer?.invalidate()
        
    }
    
    
    @IBAction func matchInfoBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
            self.matchInfoSegment.alpha = 1
            self.liveScoreSegment.alpha = 0
            self.scoreCardSegment.alpha = 0
            self.overDetailsSegment.alpha = 0
        })
        matchSquadSegment.alpha = 0

        matchInfoBtnIcon.tintColor = UIColor(named: "Secondary Dual Mode")
        matchInfoBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        liveSegmentBtn.tintColor = .systemGray2
        liveSegmentBtnText.textColor = .systemGray2
        scoreCardBtnIcon.tintColor = .systemGray2
        scoreCardBtnText.textColor = .systemGray2
        overDetailsBtnIncon.tintColor = .systemGray2
        overDetailsBtnText.textColor = .systemGray2
        matchSquadBtnIcon.tintColor = .systemGray2
        matchSquadBtnText.textColor = .systemGray2
    }
    
    
    @IBAction func liveScoreBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
            self.liveScoreSegment.alpha = 1
            self.matchInfoSegment.alpha = 0
            self.scoreCardSegment.alpha = 0
            self.overDetailsSegment.alpha = 0
        })
        matchSquadSegment.alpha = 0

        liveSegmentBtn.tintColor = UIColor(named: "Secondary Dual Mode")
        liveSegmentBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        matchInfoBtnIcon.tintColor = .systemGray2
        matchInfoBtnText.textColor = .systemGray2
        scoreCardBtnIcon.tintColor = .systemGray2
        scoreCardBtnText.textColor = .systemGray2
        overDetailsBtnIncon.tintColor = .systemGray2
        overDetailsBtnText.textColor = .systemGray2
        matchSquadBtnIcon.tintColor = .systemGray2
        matchSquadBtnText.textColor = .systemGray2
    }

    
    
    
    @IBAction func scoreCardbtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
            self.scoreCardSegment.alpha = 1
            self.liveScoreSegment.alpha = 0
            self.matchInfoSegment.alpha = 0
            self.overDetailsSegment.alpha = 0
        })
        matchSquadSegment.alpha = 0
        
        scoreCardBtnIcon.tintColor = UIColor(named: "Secondary Dual Mode")
        scoreCardBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        liveSegmentBtn.tintColor = .systemGray2
        liveSegmentBtnText.textColor = .systemGray2
        matchInfoBtnIcon.tintColor = .systemGray2
        matchInfoBtnText.textColor = .systemGray2
        overDetailsBtnIncon.tintColor = .systemGray2
        overDetailsBtnText.textColor = .systemGray2
        matchSquadBtnIcon.tintColor = .systemGray2
        matchSquadBtnText.textColor = .systemGray2
    }
    
    
    @IBAction func overDetailsBtnAction(_ sender: Any) {

        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
            self.overDetailsSegment.alpha = 1
            self.liveScoreSegment.alpha = 0
            self.matchInfoSegment.alpha = 0
            self.scoreCardSegment.alpha = 0
        })
        matchSquadSegment.alpha = 0
        
        
        overDetailsBtnIncon.tintColor = UIColor(named: "Secondary Dual Mode")
        overDetailsBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        liveSegmentBtn.tintColor = .systemGray2
        liveSegmentBtnText.textColor = .systemGray2
        matchInfoBtnIcon.tintColor = .systemGray2
        matchInfoBtnText.textColor = .systemGray2
        scoreCardBtnIcon.tintColor = .systemGray2
        scoreCardBtnText.textColor = .systemGray2
        matchSquadBtnIcon.tintColor = .systemGray2
        matchSquadBtnText.textColor = .systemGray2
    }
    
    
    @IBAction func matchSquadBtnAction(_ sender: Any) {
        
        
        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
            self.matchSquadSegment.alpha = 1
            self.matchInfoSegment.alpha = 0
            self.liveScoreSegment.alpha = 0
            self.scoreCardSegment.alpha = 0
            self.overDetailsSegment.alpha = 0
        })
        self.matchSquadBtnIcon.tintColor = UIColor(named: "Secondary Dual Mode")
        self.matchSquadBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        liveSegmentBtn.tintColor = .systemGray2
        liveSegmentBtnText.textColor = .systemGray2
        self.matchInfoBtnIcon.tintColor = .systemGray2
        self.matchInfoBtnText.textColor = .systemGray2
        self.scoreCardBtnIcon.tintColor = .systemGray2
        self.scoreCardBtnText.textColor = .systemGray2
        self.overDetailsBtnIncon.tintColor = .systemGray2
        self.overDetailsBtnText.textColor = .systemGray2
    }
    
    
    func setupBinder() {
        MatchDetailsViewController.matchDetailsViewModel.$matchDetails.sink { [weak self] matchDetails in
            
            guard let matchDetails = matchDetails else {return}
            
            dump(matchDetails)
            
            DispatchQueue.main.async {
                
                guard let self = self else {return}
                
                self.leagueName.text = matchDetails.league?.name
                let dateTime = Shared().getReadableDateTime(data: matchDetails.starting_at ?? "")
                self.matchDate.text = dateTime.1 + ", " + dateTime.0
                
                self.team1Name.text = matchDetails.localteam?.name
                self.team2Name.text = matchDetails.visitorteam?.name
                self.team1Flag.sd_setImage(
                    with: URL(string: matchDetails.localteam?.image_path ?? ""),
                    placeholderImage: UIImage(named: "teamLogo")
                )
                self.team2Flag.sd_setImage(
                    with: URL(string: matchDetails.visitorteam?.image_path ?? ""),
                    placeholderImage: UIImage(named: "teamLogo")
                )
            
            
                if matchDetails.status != "NS" {
                    if matchDetails.runs.count == 2 {
                        if(matchDetails.localteam_id == matchDetails.runs[0].team_id) {
                            self.team1Score.text = String(matchDetails.runs[0].score ?? 0)+"/" + String(matchDetails.runs[0].wickets ?? 0)
                            self.team1Over.text = "("+String(matchDetails.runs[0].overs ?? 0)+")"
                            
                            self.team2Score.text = String(matchDetails.runs[1].score ?? 0)+"/" + String(matchDetails.runs[1].wickets ?? 0)
                            self.team2Over.text = "("+String(matchDetails.runs[1].overs ?? 0)+")"
                        } else {
                            self.team1Score.text = String(matchDetails.runs[1].score ?? 0)+"/" + String(matchDetails.runs[1].wickets ?? 0)
                            self.team1Over.text = "("+String(matchDetails.runs[1].overs ?? 0)+")"
                            
                            self.team2Score.text = String(matchDetails.runs[0].score ?? 0)+"/" + String(matchDetails.runs[0].wickets ?? 0)
                            self.team2Over.text = "("+String(matchDetails.runs[0].overs ?? 0)+")"
                        }
                    } else {
                        if(matchDetails.localteam_id == matchDetails.runs[0].team_id) {
                            self.team1Score.text = String(matchDetails.runs[0].score ?? 0)+"/" + String(matchDetails.runs[0].wickets ?? 0)
                            self.team1Over.text = "("+String(matchDetails.runs[0].overs ?? 0)+")"
                        } else {
                            self.team2Score.text = String(matchDetails.runs[0].score ?? 0)+"/" + String(matchDetails.runs[0].wickets ?? 0)
                            self.team2Over.text = "("+String(matchDetails.runs[0].overs ?? 0)+")"
                        }
                    }
                    
                }
            }
          
                
 
            
        }.store(in: &cancellables)
    }
    

}
