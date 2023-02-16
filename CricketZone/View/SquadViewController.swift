//
//  SquadViewController.swift
//  CricketZone
//
//  Created by Admin on 16/2/23.
//

import UIKit
import Combine

class SquadViewController: UIViewController {
 

    @IBOutlet weak var teamSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    private var cancellables: Set<AnyCancellable> = []
    
    let squadViewModel = SquadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configurePlayerCell()
        setupBinder()

    }
    
    func configurePlayerCell(){
        let playerNib = UINib(nibName: Constants.playerTableViewCellId, bundle: nil)
        tableView.register(playerNib, forCellReuseIdentifier: Constants.playerTableViewCellId)
    }
    
    
    func setupBinder() {
        MatchDetailsViewController.matchDetailsViewModel.$matchInfo.sink { [weak self] matchData in
            guard let self = self else {return}
            guard let matchData = matchData else {return}
            
            dump(matchData)
            DispatchQueue.main.async {
                self.configureTeamSegment()
            }
            
            self.squadViewModel.prepareTeamWiseLineup(teamId: matchData.localteam?.id ?? 0)
        }.store(in: &cancellables)

        squadViewModel.$teamLineup.sink { [weak self] data in
            guard let self = self else {return}
            
            dump(data)

            DispatchQueue.main.async {
                self.tableView.reloadSections([0], with: .automatic)

            }
            
        }.store(in: &cancellables)
    }
    
    func configureTeamSegment(){
        teamSegment.setTitle(MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam?.name, forSegmentAt: 0)
        teamSegment.setTitle(MatchDetailsViewController.matchDetailsViewModel.matchDetails?.visitorteam?.name, forSegmentAt: 1)
    }
    
    
    
    @IBAction func teamSegmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                squadViewModel.prepareTeamWiseLineup(teamId: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam?.id ?? 0)
            case 1:
                squadViewModel.prepareTeamWiseLineup(teamId: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.visitorteam?.id ?? 0)
            default:
                break
            }
        
    }
    

}


extension SquadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return squadViewModel.teamLineup?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerTableViewCellId, for: indexPath) as? PlayerTableViewCell
        guard let playerCell = playerCell else {return UITableViewCell()}
        
        guard let teamLineup = squadViewModel.teamLineup else {return UITableViewCell()}
        
        playerCell.playerName.text = teamLineup[indexPath.row].fullname
        playerCell.playerPosition.text = teamLineup[indexPath.row].position?.name
        playerCell.playerImage.sd_setImage(
            with: URL(string: teamLineup[indexPath.row].image_path ?? ""),
            placeholderImage: UIImage(named: "player")
        )
        
        if teamLineup[indexPath.row].lineup?.captain == true {
            playerCell.captainIcon.isHidden = false
        } else {
            playerCell.captainIcon.isHidden = true
        }
        
        
        
        return playerCell
    }
    
}



extension SquadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let playerCell = squadViewModel.teamLineup else { return }
        
        squadViewModel.goToPlayerDetailsPage(playerId: playerCell[indexPath.row].id ?? 0, originVC: self)
    }
}
