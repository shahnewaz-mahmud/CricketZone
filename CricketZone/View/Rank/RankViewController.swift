//
//  RankViewController.swift
//  CricketZone
//
//  Created by Admin on 20/2/23.
//

import UIKit

class RankViewController: UIViewController {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configureHeaderView()
        configureTeamCell()

    }
    
    func configureHeaderView() {
        headerBackground.clipsToBounds = true
        headerBackground.layer.cornerRadius = 20
        headerBackground.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        headerBackground.dropShadow()
    }
    
    func configureTeamCell(){
        let teamNib = UINib(nibName: Constants.rankTableViewCellId, bundle: nil)
        tableView.register(teamNib, forCellReuseIdentifier: Constants.rankTableViewCellId)
    }

}

extension RankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rankCell = tableView.dequeueReusableCell(withIdentifier: Constants.rankTableViewCellId, for: indexPath) as? RankTableViewCell
        guard let rankCell = rankCell else {return UITableViewCell()}
        
//        guard let playerList = playerViewModel.playerList else {return UITableViewCell()}
//
//        playerCell.playerName.text = playerList[indexPath.row].fullName
//        playerCell.playerPosition.text = ""
//        playerCell.playerImage.sd_setImage(
//            with: URL(string: playerList[indexPath.row].imagePath ?? ""),
//            placeholderImage: UIImage(named: "player")
//        )
//            playerCell.captainIcon.isHidden = true
  
        
        
        
        return rankCell
    }
    
}

extension RankViewController: UITableViewDelegate {
    
}
