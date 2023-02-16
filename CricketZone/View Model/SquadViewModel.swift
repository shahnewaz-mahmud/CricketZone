//
//  SquadViewModel.swift
//  CricketZone
//
//  Created by Admin on 16/2/23.
//

import Foundation
import UIKit

class SquadViewModel {
    @Published var teamLineup: [LineupInfo]?
    
    func prepareTeamWiseLineup(teamId: Int){
        
        guard let matchData = MatchDetailsViewController.matchDetailsViewModel.matchDetails else {return}
        
        var lineup: [LineupInfo] = []
        
        guard let lineupList = matchData.lineup else {return}
        
        if !lineupList.isEmpty {
            for i in 0...(lineupList.count - 1) {
                if teamId == lineupList[i].lineup?.team_id {
                    lineup.append(lineupList[i])
                }
            }
        }
        teamLineup = lineup
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
