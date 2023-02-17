//
//  PlayerOverviewViewController.swift
//  CricketZone
//
//  Created by Admin on 17/2/23.
//

import UIKit
import Combine

class PlayerOverviewViewController: UIViewController {
    
    private var cancellables: Set<AnyCancellable> = []
   
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configurePlayerInfoCell()
        setupBinder()
        

    }
    
    
    func configurePlayerInfoCell(){
        let infoNib = UINib(nibName: Constants.playerInfoTableViewCellId, bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: Constants.playerInfoTableViewCellId)
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

extension PlayerOverviewViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let playerAgeCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerInfoTableViewCellId, for: indexPath) as? PlayerInfoTableViewCell
            
            guard let playerAgeCell = playerAgeCell else {return UITableViewCell()}
            
            playerAgeCell.card1Value.text = PlayerDetailsViewModel.shared.playerDetails?.dateofbirth
            
            playerAgeCell.card1Label.text = "Date of Birth"
            
            let age = Shared().calculateAge(birthdateString: PlayerDetailsViewModel.shared.playerDetails?.dateofbirth ?? "")
            
            playerAgeCell.card2value.text = (age ?? "") + " Years"
            
            playerAgeCell.card2Label.text = "Age"
            
            return playerAgeCell
            
        case 1:
            let playerSecondCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerInfoTableViewCellId, for: indexPath) as? PlayerInfoTableViewCell
            
            guard let playerSecondCell = playerSecondCell else {return UITableViewCell()}
            
            if PlayerDetailsViewModel.shared.playerDetails?.gender == "m" {
                playerSecondCell.card1Value.text = "Male"
            } else {
                playerSecondCell.card1Value.text = "Female"
            }
            
            playerSecondCell.card1Label.text = "Gender"
            
            playerSecondCell.card2value.text = PlayerDetailsViewModel.shared.playerDetails?.position?.name
            
            playerSecondCell.card2Label.text = "Playing Role"

            return playerSecondCell
            
        case 2:
            let playerThirdCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerInfoTableViewCellId, for: indexPath) as? PlayerInfoTableViewCell
            
            guard let playerThirdCell = playerThirdCell else {return UITableViewCell()}
            
            playerThirdCell.card1Value.text = PlayerDetailsViewModel.shared.playerDetails?.battingstyle
            playerThirdCell.card1Label.text = "Batting Style"
            
            playerThirdCell.card2value.text = PlayerDetailsViewModel.shared.playerDetails?.bowlingstyle
            playerThirdCell.card2Label.text = "Bowling Style"

            return playerThirdCell
            
        default:
            return UITableViewCell()
        }
    }
    
}

extension PlayerOverviewViewController: UITableViewDelegate {
    
}
