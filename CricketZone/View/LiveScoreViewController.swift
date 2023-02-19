//
//  LiveScoreViewController.swift
//  CricketZone
//
//  Created by Shahnewaz on 18/2/23.
//

import UIKit
import Combine

class LiveScoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let liveScoreViewModel = LiveScoreViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureScoreCardHeader()
        configureScoreCardCell()
        setupBinder()

    }
    
    
    func configureScoreCardHeader(){
        let headerNib = UINib(nibName: Constants.scoreCardHeaderId, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.scoreCardHeaderId)
    }
    
    func configureScoreCardCell(){
        let infoNib = UINib(nibName: Constants.scoreCardTableViewCellId, bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: Constants.scoreCardTableViewCellId)
        
        let winProbabilityNib = UINib(nibName: Constants.winProbabilityTableViewCellId, bundle: nil)
        tableView.register(winProbabilityNib, forCellReuseIdentifier: Constants.winProbabilityTableViewCellId)
    }
    
    func setupBinder() {
        MatchDetailsViewController.matchDetailsViewModel.$matchInfo.sink { [weak self] matchData in
            guard let self = self else {return}
            guard let matchData = matchData else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
  
            self.liveScoreViewModel.prepareLiveScoreData(matchData: matchData)
        }.store(in: &cancellables)
        
        liveScoreViewModel.$liveBattingDetails.sink { [weak self] batting in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.tableView.reloadSections([0,1], with: .automatic)
                
            }
            
        }.store(in: &cancellables)
    }

}



extension LiveScoreViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return liveScoreViewModel.liveBattingDetails?.count ?? 0
        } else if section == 1 {
            return liveScoreViewModel.liveBowlingDetails?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let batsmanCell = tableView.dequeueReusableCell(withIdentifier: Constants.scoreCardTableViewCellId, for: indexPath) as? ScoreCardTableViewCell
            guard let batsmanCell = batsmanCell else {return UITableViewCell()}
            
            guard let battingDetails = liveScoreViewModel.liveBattingDetails else {return UITableViewCell()}
            
            if battingDetails[indexPath.row].active == true {
                batsmanCell.playerName.text = "*" + (battingDetails[indexPath.row].batsman?.firstname ?? "")
            } else {
                batsmanCell.playerName.text = battingDetails[indexPath.row].batsman?.firstname
            }
            
            
            batsmanCell.outInfo.text = ""
            batsmanCell.score1.text = String(battingDetails[indexPath.row].score ?? 0)
            batsmanCell.score2.text = String(battingDetails[indexPath.row].ball ?? 0)
            batsmanCell.score3.text = String(battingDetails[indexPath.row].four_x ?? 0)
            batsmanCell.score4.text = String(battingDetails[indexPath.row].six_x ?? 0)
            batsmanCell.score5.text = String(battingDetails[indexPath.row].rate ?? 0)
            
            return batsmanCell
            
            
        case 1:
            let bowlerCell = tableView.dequeueReusableCell(withIdentifier: Constants.scoreCardTableViewCellId, for: indexPath) as? ScoreCardTableViewCell
            guard let bowlerCell = bowlerCell else {return UITableViewCell()}
            guard let bowlingDetails = liveScoreViewModel.liveBowlingDetails else { return UITableViewCell()}
            
            bowlerCell.playerName.text = bowlingDetails[indexPath.row].bowler?.firstname
            bowlerCell.outInfo.text = ""
            bowlerCell.score1.text = String(bowlingDetails[indexPath.row].overs ?? 0)
            bowlerCell.score2.text = String(bowlingDetails[indexPath.row].medians ?? 0)
            bowlerCell.score3.text = String(bowlingDetails[indexPath.row].runs ?? 0)
            bowlerCell.score4.text = String(bowlingDetails[indexPath.row].wickets ?? 0)
            bowlerCell.score5.text = String(bowlingDetails[indexPath.row].rate ?? 0)

            return bowlerCell
            
        case 2:
            let winProbabilityCell = tableView.dequeueReusableCell(withIdentifier: Constants.winProbabilityTableViewCellId, for: indexPath) as? WinProbabilityTableViewCell
            guard let winProbabilityCell = winProbabilityCell else {return UITableViewCell()}
            
            winProbabilityCell.team1Flag.sd_setImage(
                with: URL(string: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam?.image_path ?? ""),
                placeholderImage: UIImage(named: "teamLogo")
            )
            winProbabilityCell.team2Flag.sd_setImage(
                with: URL(string: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.visitorteam?.image_path ?? ""),
                placeholderImage: UIImage(named: "teamLogo")
            )
            
            winProbabilityCell.team1Name.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam?.code
            winProbabilityCell.team2Name.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.visitorteam?.code
            
            return winProbabilityCell
        

        
        default:
            return UITableViewCell()
        }
        
    }
 
    //Header
    
    //For tableView Section Header
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section == 0
            {
                let batsmanSectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.scoreCardHeaderId) as! ScoreCardTVHeaderView
                batsmanSectionHeader.playerType.text = "Batsman"
                batsmanSectionHeader.scoreType1.text = "R"
                batsmanSectionHeader.scoreType2.text = "B"
                batsmanSectionHeader.scoreType3.text = "4s"
                batsmanSectionHeader.scoreType4.text = "6s"
                batsmanSectionHeader.scoreType5.text = "SR"

                return batsmanSectionHeader
            } else if section == 1
            {
                let bowlingSectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.scoreCardHeaderId) as! ScoreCardTVHeaderView
                
                bowlingSectionHeader.playerType.text = "Bowler"
                bowlingSectionHeader.scoreType1.text = "O"
                bowlingSectionHeader.scoreType2.text = "M"
                bowlingSectionHeader.scoreType3.text = "R"
                bowlingSectionHeader.scoreType4.text = "W"
                bowlingSectionHeader.scoreType5.text = "ER"

                return bowlingSectionHeader
            } else {
                return UIView()
            }
        }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2{
            return 0
        } else {
            return 60
        }
        
    }
}

extension LiveScoreViewController: UITableViewDelegate {
    
}

