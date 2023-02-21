//
//  RankViewModel.swift
//  CricketZone
//
//  Created by Shahnewaz on 21/2/23.
//

import Foundation

class RankViewModel {
    
    @Published var teamRankingList: [RankData]?
    @Published var teamList: [TeamDetails]?
    
    func fetchTeamRanking() {
        guard let url = cricketAPIConfig.apiGetTeamRankURL else {
            return
        }
        print(url)
        
        APIService.fetchData(from: url) { (result: Result<TeamRanking, Error>) in
            switch result {
            case .failure(let error):
                // TO-DO: handle no internet error
                if let error = error as? URLError,
                   error.code == .notConnectedToInternet {
                    print("Internet connection error")
                } else {
                    print(error.localizedDescription)
                }
            case .success(let ranking):
                print("Ranking List",ranking)
                self.teamRankingList = ranking.data
                print("Ranking List",self.teamRankingList )
            }
        }
    }
    
    func getCategoryWiseRankList(teamRankingList: [RankData]?, category: String) {

        if category == "ODI" {
            teamList = teamRankingList?[1].team
        } else if category == "TEST" {
            print(teamRankingList?[0].team?.count)
            teamList = teamRankingList?[0].team.map{$0}
        } else {
            teamList = teamRankingList?[2].team
        }
        
    }
}
