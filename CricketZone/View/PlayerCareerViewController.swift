//
//  PlayerCareerViewController.swift
//  CricketZone
//
//  Created by Admin on 17/2/23.
//

import UIKit
import Combine

class PlayerCareerViewController: UIViewController {
    
    
    
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        configurePlayerCareerCell()

    }
    
    func configurePlayerCareerCell(){
        let careerNib = UINib(nibName: Constants.playerCareerTableViewCellId, bundle: nil)
        tableView.register(careerNib, forCellReuseIdentifier: Constants.playerCareerTableViewCellId)
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

extension PlayerCareerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlayerDetailsViewModel.shared.playerDetails?.career?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let battingCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerCareerTableViewCellId, for: indexPath) as? PlayerCareerTableViewCell
        
        guard let battingCell = battingCell else {return UITableViewCell()}
        
        
        let carrValue1 = battingCell.viewWithTag(1) as? UILabel
        carrValue1?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["matches"] ?? 0)
        
        let carrValue2 = battingCell.viewWithTag(2) as? UILabel
        carrValue2?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["innings"] ?? 0)
        
        let carrValue3 = battingCell.viewWithTag(3) as? UILabel
        carrValue3?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["runs_scored"] ?? 0)
        
        let carrValue4 = battingCell.viewWithTag(4) as? UILabel
        carrValue4?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["not_outs"] ?? 0)
        
        let carrValue5 = battingCell.viewWithTag(5) as? UILabel
        carrValue5?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["highest_inning_score"] ?? 0)
        
        let carrValue6 = battingCell.viewWithTag(6) as? UILabel
        carrValue6?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["strike_rate"] ?? 0)
        
        let carrValue7 = battingCell.viewWithTag(7) as? UILabel
        carrValue7?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["balls_faced"] ?? 0)
        
        let carrValue8 = battingCell.viewWithTag(8) as? UILabel
        carrValue8?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["average"] ?? 0)
        
        let carrValue9 = battingCell.viewWithTag(9) as? UILabel
        carrValue9?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["four_x"] ?? 0)
        
        let carrValue10 = battingCell.viewWithTag(10) as? UILabel
        carrValue10?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["six_x"] ?? 0)
        
        let carrValue11 = battingCell.viewWithTag(11) as? UILabel
        carrValue11?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["hundreds"] ?? 0)
        
        let carrValue12 = battingCell.viewWithTag(12) as? UILabel
        carrValue12?.text = String(PlayerDetailsViewModel.shared.playerDetails?.career?[indexPath.row].batting?["fifties"] ?? 0)
        
        return battingCell
    }
    
}
