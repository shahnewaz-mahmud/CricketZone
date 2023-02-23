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
                guard let match = match.data else {return}
                
                if (match.count == 0) {
                    self.fetchUpcomingMatch()
                    
                } else {
                    self.liveMatchList = match
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
    
    func prepareMatchNotification() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let laterDate = calendar.date(byAdding: .day, value: 7, to: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDateString = dateFormatter.string(from: currentDate)
        let laterDateString = dateFormatter.string(from: laterDate!)
        
        guard let url = cricketAPIConfig.getSpecificDateFixtureAPIUrl(date1: currentDateString, date2: laterDateString) else {
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
                self.setNotification(matchList: match.data, lastDate: laterDate)
                
            }
        }
    }
    
    
    
    func setNotification(matchList: [Match]?, lastDate: Date?) {
        
        guard let matchList = matchList else { return }
        print(matchList.count)
        for i in 0...matchList.count - 1 {
            
            let currentTime = Date()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
            let matchDate = dateFormatter.date(from: matchList[i].starting_at ?? "")
            
            guard let matchDate = matchDate else {
                return
            }
            
            
            var timeInterval = matchDate.timeIntervalSince(currentTime)
            
            if matchDate.compare(currentTime) == .orderedDescending {
                
                if timeInterval < 10000 {
                    continue
                }
                
                timeInterval -= 900
                
                let content = UNMutableNotificationContent()
                content.title = (matchList[i].localteam?.code ?? "") + " Vs " + (matchList[i].visitorteam?.code ?? "")
                content.body = (matchList[i].type ?? "") + " Live Match " + content.title  + " is Starting Soon!"
                content.sound = .default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
                
                // Create the request with a unique identifier
                let request = UNNotificationRequest(identifier: "Cricket-Zone-Notification \(i)", content: content, trigger: trigger)
                
                // Add the request to the notification center
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
                        print("Notification scheduled.")
                    }
                    
                }
                
            }
            
            let userInfo = UserDefaultsHelper.shared.getSavedData(key: Constants.userDefaultsUser)
            
            guard let lastDate = lastDate else {return}
            
            guard var userInfo = userInfo else {
                let newUser = User(isDarkmode: false, lastNotificationSet: lastDate)
                UserDefaultsHelper.shared.saveUserData(userInfo: newUser, key: Constants.userDefaultsUser)
                return
                
            }
            
            userInfo.lastNotificationSet = lastDate
            UserDefaultsHelper.shared.saveUserData(userInfo: userInfo, key: Constants.userDefaultsUser)
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
