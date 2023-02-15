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
    
    func fetchMatchDetails(matchId: Int) {

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
}
