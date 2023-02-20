//
//  PlayerViewModel.swift
//  CricketZone
//
//  Created by Admin on 20/2/23.
//

import Foundation
import UIKit



class PlayerViewModel {
    
    @Published var playerList: [PlayerModel]?
    
    func searchPlayer(playerName: String) {
        playerList = CoreDataHelper.shared.searchPlayers(searchText: playerName)
    }
    
    func goToPlayerDetailsPage(playerId: Int, originVC: UIViewController) {
        let playerDetailsVC = UIStoryboard(
            name: "PlayerDetails", bundle: nil
        ).instantiateViewController(withIdentifier: Constants.playerDetailsVCID)
            as? PlayerDetailsViewController

        guard let playerDetailsVC = playerDetailsVC else { return }

        playerDetailsVC.loadViewIfNeeded()
        
        //playerDetailsVC.selectedMatchId = matchId
        
        PlayerDetailsViewModel.shared.fetchPlayerDetails(playerId: playerId)


        originVC.navigationController?.pushViewController(playerDetailsVC, animated: true)
    }
    
    
}
