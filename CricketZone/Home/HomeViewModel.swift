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

    
    func fetchLiveMatch() {
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
    
    func goToMatchDetailsPage(indexpath: IndexPath, originVC: HomeViewController) {
        let matchDetailsVC = UIStoryboard(
            name: "Home", bundle: nil
        ).instantiateViewController(withIdentifier: Constants.matchDetailsVCId)
            as? MatchDetailsViewController

        guard let matchDetailsVC = matchDetailsVC else { return }

        matchDetailsVC.loadViewIfNeeded()

        //newsDetailsVC.newsDetailsViewModel.setNewsDetails(newsDetails: newsList.value?[indexpath.row])
        originVC.navigationController?.pushViewController(matchDetailsVC, animated: true)
    }
    
}