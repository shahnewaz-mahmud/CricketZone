//
//  ScoreCardViewController.swift
//  CricketZone
//
//  Created by BJIT on 2/15/23.
//

import UIKit
import Combine

class ScoreCardViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    private var cancellables: Set<AnyCancellable> = []
    let scoreCardViewModel = ScoreCardViewModel()
    
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
    }
    
    func setupBinder() {
        MatchDetailsViewController.matchDetailsViewModel.$matchInfo.sink { [weak self] _ in
            guard let self = self else {return}
            self.scoreCardViewModel.prepareTeamWiseScoreData()
        }.store(in: &cancellables)
        
        scoreCardViewModel.$localTeamBattingDetails.sink { [weak self] batting in
            guard let self = self else {return}
            
            print(batting?.count)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.store(in: &cancellables)
    }


}

extension ScoreCardViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return scoreCardViewModel.localTeamBattingDetails?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let batsmanCell = tableView.dequeueReusableCell(withIdentifier: Constants.scoreCardTableViewCellId, for: indexPath) as? ScoreCardTableViewCell
            guard let batsmanCell = batsmanCell else {return UITableViewCell()}
            
            batsmanCell.playerName.text = scoreCardViewModel.localTeamBattingDetails?[indexPath.row].batsman?.fullname
            batsmanCell.outInfo.text = scoreCardViewModel.localTeamBattingDetails?[indexPath.row].result?.name
            
            batsmanCell.run.text = String(scoreCardViewModel.localTeamBattingDetails?[indexPath.row].score ?? 0)
            batsmanCell.ball.text = String(scoreCardViewModel.localTeamBattingDetails?[indexPath.row].ball ?? 0)
            batsmanCell.fours.text = String(scoreCardViewModel.localTeamBattingDetails?[indexPath.row].four_x ?? 0)
            batsmanCell.sixes.text = String(scoreCardViewModel.localTeamBattingDetails?[indexPath.row].six_x ?? 0)
            batsmanCell.strikeRate.text = String(scoreCardViewModel.localTeamBattingDetails?[indexPath.row].rate ?? 0)
            
            return batsmanCell
        

        
        default:
            return UITableViewCell()
        }
        
    }
        
    
    
    
    //Header
    
    //For tableView Section Header
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section == 0
            {
                let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.scoreCardHeaderId) as! ScoreCardTVHeaderView

                return sectionHeader
            } else {
                return UIView()
            }
        }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension ScoreCardViewController: UITableViewDelegate {
    
}
