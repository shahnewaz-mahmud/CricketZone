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
    
    var localTeamWinRecords: [Bool]?
    var visitorTeamWinRecords: [Bool]?
    
    
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
                self.prepareWinRecord(matchDetails: match.data)
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
                dump(overs.data)
                self.overDetails = overs.data?.balls
            }
        }
    }
    
    func prepareWinRecord(matchDetails: MatchData?) {
        print("Match Result",matchDetails)
        var visitorTeamMatchCount = matchDetails?.visitorteam?.results?.count ?? 0
        
        if visitorTeamMatchCount != 0 {
            if visitorTeamMatchCount > 5 {
                visitorTeamMatchCount = 5
            }
            
            var visitorTeamrecords: [Bool] = Array(repeating: false, count: 5)
            
            for i in 0...visitorTeamMatchCount - 1 {
                if String(matchDetails?.visitorteam?.results?[i].winner_team_id ?? 0) == String(matchDetails?.visitorteam?.id ?? 0) {
                    visitorTeamrecords[i] = true
                } else {
                    visitorTeamrecords[i] = false
                }
            }
            
            visitorTeamWinRecords = visitorTeamrecords
            print(visitorTeamrecords)
        }
        

        var localTeamMatchCount = matchDetails?.localteam?.results?.count ?? 0
        
        
        if localTeamMatchCount != 0 {
            if localTeamMatchCount > 5 {
                localTeamMatchCount = 5
            }

            var localTeamRecords: [Bool] = Array(repeating: false, count: 5)
            
            for i in 0...localTeamMatchCount - 1 {
                if String(matchDetails?.localteam?.results?[i].winner_team_id ?? 0) == String(matchDetails?.localteam?.id ?? 0) {
                    localTeamRecords[i] = true
                } else {
                    localTeamRecords[i] = false
                }
            }
            localTeamWinRecords = localTeamRecords
            print(localTeamRecords)
        }

    }
    
    
    
    
    
}
