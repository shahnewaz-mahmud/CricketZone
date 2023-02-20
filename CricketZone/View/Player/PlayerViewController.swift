//
//  PlayerViewController.swift
//  CricketZone
//
//  Created by Admin on 20/2/23.
//

import UIKit
import Combine

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var headerBackground: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var cancellables: Set<AnyCancellable> = []
    
    let playerViewModel = PlayerViewModel()
    
    @IBOutlet weak var searchField: UITextField!
    
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHeaderView()
        
        tableView.dataSource = self
        tableView.delegate = self
        configurePlayerCell()
        setupBinder()
        
        searchField.addTarget(self, action: #selector(searchPlayers), for: .editingChanged)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchField.text = ""
        playerViewModel.searchPlayer(playerName: "A")
    }
    
    func configureHeaderView() {
        headerBackground.clipsToBounds = true
        headerBackground.layer.cornerRadius = 20
        headerBackground.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        headerBackground.dropShadow()
        searchField.padding = 30
    }
    
    func configurePlayerCell(){
        let playerNib = UINib(nibName: Constants.playerTableViewCellId, bundle: nil)
        tableView.register(playerNib, forCellReuseIdentifier: Constants.playerTableViewCellId)
    }
    
    func setupBinder() {
        playerViewModel.$playerList.sink { [weak self] _ in
            
            guard let self = self else {return}

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.store(in: &cancellables)
    }
    
    @objc func searchPlayers()
    {
        if let searchText = searchField.text {
            if searchText == ""{
                isSearch = false
                playerViewModel.searchPlayer(playerName: "A")
                
            } else {
                isSearch = true
                playerViewModel.searchPlayer(playerName: searchField.text ?? "")
                
            }
            
        }
    }
    


}


extension PlayerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let playerCell = playerViewModel.playerList else { return }
        
        playerViewModel.goToPlayerDetailsPage(playerId: Int(playerCell[indexPath.row].id ), originVC: self)
    }
    
}


extension PlayerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  playerViewModel.playerList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerCell = tableView.dequeueReusableCell(withIdentifier: Constants.playerTableViewCellId, for: indexPath) as? PlayerTableViewCell
        guard let playerCell = playerCell else {return UITableViewCell()}
        
        guard let playerList = playerViewModel.playerList else {return UITableViewCell()}

        playerCell.playerName.text = playerList[indexPath.row].fullName
        playerCell.playerPosition.text = ""
        playerCell.playerImage.sd_setImage(
            with: URL(string: playerList[indexPath.row].imagePath ?? ""),
            placeholderImage: UIImage(named: "player")
        )
            playerCell.captainIcon.isHidden = true
  
        
        
        
        return playerCell
    }
}
