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
        setupBinder()

    }
    
    func configurePlayerTeamCell(){
        let teamNib = UINib(nibName: Constants.playerTeamTableViewCellId, bundle: nil)
        tableView.register(teamNib, forCellReuseIdentifier: Constants.playerTeamTableViewCellId)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  PlayerDetailsViewModel.shared.playerDetails?.teams?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let playedTeamCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerTeamTableViewCellId, for: indexPath) as? PlayerTeamTableViewCell
            
            guard let playedTeamCell = playedTeamCell else {return UITableViewCell()}
            
            playedTeamCell.teamName.text = PlayerDetailsViewModel.shared.playerDetails?.teams?[indexPath.row].name
            playedTeamCell.teamImage.sd_setImage(
                with: URL(string: PlayerDetailsViewModel.shared.playerDetails?.teams?[indexPath.row].image_path ?? ""),
                placeholderImage: UIImage(named: "f2")
            )
            playedTeamCell.leagueName.text = "Big Bash League"
            playedTeamCell.season.text = "2023"
            
            return playedTeamCell
        default:
            return UITableViewCell()
        }
    }
    
}


extension PlayerTeamsViewController: UITableViewDelegate {
    
}
