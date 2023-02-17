//
//  PlayerTeamsViewController.swift
//  CricketZone
//
//  Created by Admin on 17/2/23.
//

import UIKit
import Combine



class PlayerTeamsViewController: UIViewController {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configurePlayerTeamCell()
        configurePlayerTeamsHeader()
        
        setupBinder()

    }
    
    func configurePlayerTeamCell(){
        let teamNib = UINib(nibName: Constants.playerTeamTableViewCellId, bundle: nil)
        tableView.register(teamNib, forCellReuseIdentifier: Constants.playerTeamTableViewCellId)
    }
    
    func configurePlayerTeamsHeader(){
        let headerNib = UINib(nibName: Constants.playerTeamUITableViewHeaderViewId, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.playerTeamUITableViewHeaderViewId)
    }
    
    func setupBinder() {
        PlayerDetailsViewModel.shared.$playerDetails.sink { [weak self] _ in
            
            guard let self = self else {return}

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.store(in: &cancellables)
    }

}

extension PlayerTeamsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return  PlayerDetailsViewModel.shared.playerDetails?.currentteams?.count ?? 0
        } else {
            return  PlayerDetailsViewModel.shared.playerDetails?.teams?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let currentTeamCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerTeamTableViewCellId, for: indexPath) as? PlayerTeamTableViewCell
            
            guard let currentTeamCell = currentTeamCell else {return UITableViewCell()}
            
            currentTeamCell.teamName.text = PlayerDetailsViewModel.shared.playerDetails?.teams?[indexPath.row].name
            currentTeamCell.teamImage.sd_setImage(
                with: URL(string: PlayerDetailsViewModel.shared.playerDetails?.teams?[indexPath.row].image_path ?? ""),
                placeholderImage: UIImage(named: "f2")
            )
            
            if PlayerDetailsViewModel.shared.playerDetails?.currentteams?[indexPath.row].national_team == true {
                currentTeamCell.nationalTeam.isHidden = false
            } else {
                currentTeamCell.nationalTeam.isHidden = true
            }
            
            currentTeamCell.leagueName.text = "Big Bash League"
            currentTeamCell.season.text = "2023"
            
            return currentTeamCell
            
        case 1:
            let playedTeamCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerTeamTableViewCellId, for: indexPath) as? PlayerTeamTableViewCell
            
            guard let playedTeamCell = playedTeamCell else {return UITableViewCell()}
            
            playedTeamCell.teamName.text = PlayerDetailsViewModel.shared.playerDetails?.teams?[indexPath.row].name
            playedTeamCell.teamImage.sd_setImage(
                with: URL(string: PlayerDetailsViewModel.shared.playerDetails?.teams?[indexPath.row].image_path ?? ""),
                placeholderImage: UIImage(named: "f2")
            )
            
            if PlayerDetailsViewModel.shared.playerDetails?.teams?[indexPath.row].national_team == true  {
                playedTeamCell.nationalTeam.isHidden = false
            } else {
                playedTeamCell.nationalTeam.isHidden = true
            }
            
            playedTeamCell.leagueName.text = "Big Bash League"
            playedTeamCell.season.text = "2023"
            
            return playedTeamCell
        default:
            return UITableViewCell()
        }
    }
    
    //Header
    
    //For tableView Section Header
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section == 0
            {
                let currentTeamHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.playerTeamUITableViewHeaderViewId) as! PlayerTeamUITableViewHeaderView
                currentTeamHeader.headerLabel.text = "Current Team"
                return currentTeamHeader
            } else if section == 1
            {
                let allTeamHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.playerTeamUITableViewHeaderViewId) as! PlayerTeamUITableViewHeaderView
                allTeamHeader.headerLabel.text = "Teams Played for"
                return allTeamHeader
            } else {
                return UIView()
            }
        }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}


extension PlayerTeamsViewController: UITableViewDelegate {
    
}
