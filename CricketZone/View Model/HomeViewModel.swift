//
//  HomeViewModel.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import Foundation
import UIKit



class HomeViewModel {
    
    @Published var liveMatchList: [Match]?
    @Published var recentMatchList: [Match]?
    @Published var allPlayerList: PlayerList?

    
    func fetchLiveMatch() {
        guard let url = cricketAPIConfig.apiGetLiveMatchURL else {
            return
        }
        print(url)
        
        APIService.fetchData(from: url) { (result: Result<MatchList, Error>) in
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
                if ((match.data?.isEmpty) != nil) {
                    self.fetchUpcomingMatch()
                } else {
                    self.liveMatchList = match.data
                }
                
            }
        }
    }
    
    func fetchUpcomingMatch() {
        guard let url = cricketAPIConfig.apiGetUpcomingMatchURL else {
            return
        }
        print(url)
        
        APIService.fetchData(from: url) { (result: Result<MatchList, Error>) in
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
                self.liveMatchList = match.data
            }
        }
    }
    
    
    func fetchRecentMatch() {
        guard let url = cricketAPIConfig.apiGetRecentMatchURL else {
            return
        }
        print(url)
        
        APIService.fetchData(from: url) { (result: Result<MatchList, Error>) in
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
                self.recentMatchList = match.data
            }
        }
    }
    
    func fetchAllPlayers() {
        
        let playerList = CoreDataHelper.shared.searchPlayers(searchText: "A")
        if playerList.isEmpty {
            print("Fetching from API")
            guard let url = cricketAPIConfig.apiGetAllPlayersURL else {
                return
            }
            print(url)
            
            APIService.fetchData(from: url) { (result: Result<PlayerList, Error>) in
                switch result {
                case .failure(let error):
                    // TO-DO: handle no internet error
                    if let error = error as? URLError,
                       error.code == .notConnectedToInternet {
                        print("Internet connection error")
                    } else {
                        print(error.localizedDescription)
                    }
                case .success(let playerList):
                    self.allPlayerList = playerList
                    self.savePlayersToCoreData()
                }
            }
        }
        
    }
    
    
    func savePlayersToCoreData(){
        guard let allPlayerList = allPlayerList else {return}
        CoreDataHelper.shared.addItems(data: allPlayerList)
    }
    
    
    
    func goToMatchDetailsPage(matchId: Int, isLive: Bool, originVC: HomeViewController) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let matchDetailsVC = storyboard.instantiateViewController(withIdentifier: Constants.matchDetailsVCId) as? MatchDetailsViewController else { return }

        matchDetailsVC.selectedMatchId = matchId
        matchDetailsVC.isLive = isLive

        originVC.navigationController?.pushViewController(matchDetailsVC, animated: true)
    }
    
    
    
    func fetchAllSeasons() {
        guard let url = cricketAPIConfig.apiGetAllSeasonURL else {
            return
        }
        print(url)
        
        APIService.fetchData(from: url) { (result: Result<SeasonList, Error>) in
            switch result {
            case .failure(let error):
                // TO-DO: handle no internet error
                if let error = error as? URLError,
                   error.code == .notConnectedToInternet {
                    print("Internet connection error")
                } else {
                    print(error.localizedDescription)
                }
            case .success(let seasons):
                guard let seasons = seasons.data else {return}
                
                var seasonList = [Int: String]()
                for season in seasons {
                    seasonList[season.id ?? 0] = season.name
                    }
            
                
                UserDefaultsHelper.shared.saveAllSeasons(seasonList: seasonList, key: "Season")
            }
        }
    }
    
    
    
    
}
