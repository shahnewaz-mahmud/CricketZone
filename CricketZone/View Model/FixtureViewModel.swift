//
//  FixtureViewModel.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import Foundation
import UIKit


class FixtureViewModel {
    
    @Published var dateList: [DateInfo]?
    @Published var todaysIndex: Int?
    @Published var matchList: [Match]?
    
    func getDateInfoForCurrentYear(){
        let calendar = Calendar(identifier: .gregorian)
        let today = Date()
        let startOfYear = calendar.date(from: DateComponents(year: calendar.component(.year, from: today)))!
        let dateRange = calendar.range(of: .day, in: .year, for: startOfYear)!
        
        var dateComponents = DateComponents()
        var dateInfos = [DateInfo]()
        
        for i in 0..<dateRange.count {
            let date = calendar.date(byAdding: .day, value: i, to: startOfYear)!
            
            dateComponents.year = calendar.component(.year, from: date)
            dateComponents.month = calendar.component(.month, from: date)
            dateComponents.day = calendar.component(.day, from: date)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            let day = dateFormatter.string(from: date)
            
            let dayNumber = calendar.component(.day, from: date)
            
            dateFormatter.dateFormat = "MMM"
            let month = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let fullDate = dateFormatter.string(from: date)
            
            let isToday = calendar.isDate(date, inSameDayAs: today)
            
            let dateInfo = DateInfo(id: i+1, day: day, isToday: isToday, dayNumber: dayNumber, month: month, year: dateComponents.year!, fullDate: fullDate)
            
            if dateInfo.isToday == true {
                todaysIndex = i
            }
            
            dateInfos.append(dateInfo)
        }
        
        print(dateInfos)
        
        dateList =  dateInfos
    }
    
    
    func fetcMatch(date: String = "", leagueId: Int = 0) {
        
        let url: URL?
        
        if(date != "" && leagueId == 0) {
            url = cricketAPIConfig.getSpecificDateFixtureAPIUrl(date: date)
            print(url ?? "")
        } else if (leagueId != 0 && date == "") {
            url = cricketAPIConfig.getSpecificLeagueFixtureAPIUrl(leagueId: leagueId)
            print(url ?? "")

        } else {
            url = cricketAPIConfig.apiGetUpcomingMatchURL
            print(url ?? "")
            
        }
            
            
        
        guard let url = url else {return}
        
        
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
                self.matchList = match.data
            }
        }
    }
    
    func goToMatchDetailsPage(matchId: Int, isLive: Bool, originVC: UIViewController) {
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
