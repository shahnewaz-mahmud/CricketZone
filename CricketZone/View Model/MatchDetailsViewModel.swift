//
//  MatchDetailsViewModel.swift
//  CricketZone
//
//  Created by Shahnewaz on 11/2/23.
//

import Foundation

class MatchDetailsViewModel {
    @Published var matchDetails: MatchData?
    @Published var matchInfo: MatchData?
    @Published var overDetails: [Ball]?
    
    var autoRefreshTimer: Timer?
    
    
    
    func fetchMatchDetails(matchId: Int, isLive: Bool) {
        
        syncMatchData(matchId: matchId)
        
        if isLive == true {
            autoRefreshTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
                self.syncMatchData(matchId: matchId)
            }
        }
    }
    
    
    func syncMatchData(matchId: Int){
        guard let url = cricketAPIConfig.getMatchDetailsAPIUrl(matchId: matchId) else {
            return
        }
        print(url)
        
        APIService.fetchData(from: url) { (result: Result<MatchDetails, Error>) in
            switch result {
            case .failure(let error):
                // TO-DO: handle no internet error
                if let error = error as? URLError,
                   error.code == .notConnectedToInternet {
                    print("Internet connection error")
                } else {
                    print(error.localizedDescription)
                }
            case .success(let match):
                print("Match Result",match)
                self.matchDetails = match.data
                self.matchInfo = match.data
            }
        }
        
        
    }
    
    
    func syncOversData(matchId: Int){
        guard let url = cricketAPIConfig.getOverDetailsAPIUrl(matchId: matchId) else {
            return
        }
        print(url)
        
        APIService.fetchData(from: url) { (result: Result<Overs, Error>) in
            switch result {
            case .failure(let error):
                // TO-DO: handle no internet error
                if let error = error as? URLError,
                   error.code == .notConnectedToInternet {
                    print("Internet connection error")
                } else {
                    print(error.localizedDescription)
                }
            case .success(let overs):
                print("Over Details",overs.data)
                self.overDetails = overs.data?.balls
            }
        }
        
        
    }
    
    
}
