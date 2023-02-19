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
    @Published var allPlayerList: [PlayerInfo]?

    
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
                print("Player List: ",playerList)
                self.allPlayerList = playerList.data
            }
        }
    }
    
    
    func savePlayersToCoreData(){
        if let allPlayerList = self.allPlayerList {
            if allPlayerList.count > 0{
                for i in 0...allPlayerList.count-1{
                    CoreDataHelper.shared.addPlayer(player: allPlayerList[i])
                }
            }
            
        }
    }
    
    
    
    func goToMatchDetailsPage(matchId: Int, isLive: Bool, originVC: HomeViewController) {
        let matchDetailsVC = UIStoryboard(
            name: "Home", bundle: nil
        ).instantiateViewController(withIdentifier: Constants.matchDetailsVCId)
            as? MatchDetailsViewController

        guard let matchDetailsVC = matchDetailsVC else { return }

        //matchDetailsVC.loadViewIfNeeded()
        matchDetailsVC.selectedMatchId = matchId
        matchDetailsVC.isLive = isLive

        //newsDetailsVC.newsDetailsViewModel.setNewsDetails(newsDetails: newsList.value?[indexpath.row])
        originVC.navigationController?.pushViewController(matchDetailsVC, animated: true)
    }
    
}
