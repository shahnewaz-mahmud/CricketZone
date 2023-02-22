//
//  PlayerStatsViewController.swift
//  CricketZone
//
//  Created by Admin on 22/2/23.
//

import UIKit
import Combine

class PlayerStatsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let playerStatsViewModel = PlayerStatsViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configurePlayerStatsCell()
        setupBinder()
    }
    
    func configurePlayerStatsCell(){
        let statsNib = UINib(nibName: Constants.playerStatsTableViewCellId, bundle: nil)
        tableView.register(statsNib, forCellReuseIdentifier: Constants.playerStatsTableViewCellId)
        
        let bowlerStatsNib = UINib(nibName: Constants.bowlingStatsTableViewCellId, bundle: nil)
        tableView.register(bowlerStatsNib, forCellReuseIdentifier: Constants.bowlingStatsTableViewCellId)
    }
    
    func setupBinder() {
        PlayerDetailsViewModel.shared.$playerDetails.sink { [weak self] playerDetails in
            
            guard let self = self else {return}

            self.playerStatsViewModel.getPlayerStats(playerCareer: playerDetails?.career, category: "ODI")
            
        }.store(in: &cancellables)
        
        playerStatsViewModel.$playerStats.sink { [weak self] playerDetails in
            
            guard let self = self else {return}

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.store(in: &cancellables)
    }
    
    
    @IBAction func CategorySegmentAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0:
            self.playerStatsViewModel.getPlayerStats(playerCareer: PlayerDetailsViewModel.shared.playerDetails?.career, category: "ODI")
            case 1:
            self.playerStatsViewModel.getPlayerStats(playerCareer: PlayerDetailsViewModel.shared.playerDetails?.career, category: "T20I")
            case 2:
            self.playerStatsViewModel.getPlayerStats(playerCareer: PlayerDetailsViewModel.shared.playerDetails?.career, category: "T20")
            default:
                break
        }
    }
}

extension PlayerStatsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (playerStatsViewModel.playerStats?.count == 0) {
            return 0
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let battingCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerStatsTableViewCellId, for: indexPath) as? PlayerStatsTableViewCell
            
            guard let battingCell = battingCell else {return UITableViewCell()}
            
            guard let playerStats = playerStatsViewModel.playerStats else {return UITableViewCell()}
            
            battingCell.totalMatch.text = String(playerStats["battingTotalMatch"] ?? 0.0)
            battingCell.totalRuns.text = String(playerStats["battingTotalRun"] ?? 0.0)
            battingCell.total50s.text = String(playerStats["battingTotal50s"] ?? 0.0)
            battingCell.total100s.text = String(playerStats["battingTotal100s"] ?? 0.0)
            battingCell.highestRuns.text = String(playerStats["battingHighestRun"] ?? 0.0)
            battingCell.strikeRate.text = String(playerStats["battingTotalStrikeRate"] ?? 0.0)
 
            return battingCell
            
        case 1:
            let bowlingCell = tableView.dequeueReusableCell(withIdentifier: Constants.bowlingStatsTableViewCellId, for: indexPath) as? BowlingStatsTableViewCell
            
            guard let bowlingCell = bowlingCell else {return UITableViewCell()}
            
            guard let playerStats = playerStatsViewModel.playerStats else {return UITableViewCell()}
            
            bowlingCell.totalMatch.text = String(playerStats["bowlingTotalMatch"] ?? 0.0)
            bowlingCell.totalOvers.text = String(playerStats["bowlingTotalOvers"] ?? 0.0)
            bowlingCell.ecoRate.text = String(playerStats["bowlingTotalEconRate"] ?? 0.0)
            bowlingCell.totalRuns.text = String(playerStats["bowlingTotalRuns"] ?? 0.0)
            bowlingCell.totalWickets.text = String(playerStats["bowlingTotalWickets"] ?? 0.0)
            
            return bowlingCell
            
        default:
            return UITableViewCell()
        }
        
    }
 
}

extension PlayerStatsViewController: UITableViewDelegate {
  
}
