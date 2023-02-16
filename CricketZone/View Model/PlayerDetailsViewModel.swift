//
//  PlayerDetailsViewModel.swift
//  CricketZone
//
//  Created by Admin on 16/2/23.
//

import Foundation


class PlayerDetailsViewModel {
    
    @Published var playerDetails: Player?
    
    static let shared = PlayerDetailsViewModel()
    
    func fetchPlayerDetails(playerId: Int) {

        guard let url = cricketAPIConfig.getPlayerDetailsAPIUrl(playerId: playerId) else {
            return
        }
        print(url)
        
        APIService.fetchData(from: url) { (result: Result<PlayerDetails, Error>) in
            switch result {
            case .failure(let error):
                // TO-DO: handle no internet error
                if let error = error as? URLError,
                   error.code == .notConnectedToInternet {
                    print("Internet connection error")
                } else {
                    print(error.localizedDescription)
                }
            case .success(let player):
                print("Match Result",player)
                self.playerDetails = player.data
            }
        }
    }
    
    
    
}
