//
//  LeagueModel.swift
//  CricketZone
//
//  Created by Shahnewaz on 19/2/23.
//

import Foundation


struct LeagueInfo {
    let id: Int?
    let name: String?
    let fullName: String?
    let img_path: String?
}

extension LeagueInfo {
    static let LeagueInfoList = [
        LeagueInfo(id: 3, name: "T20I", fullName: "Twenty20 International", img_path: "https://cdn.sportmonks.com/images/cricket/leagues/3/3.png"),
        LeagueInfo(id: 5, name: "BBL", fullName: "Big Bash League", img_path: "https://cdn.sportmonks.com/images/cricket/leagues/5/5.png"),
        LeagueInfo(id: 10, name: "T20C", fullName: "CSA T20 Challenge", img_path: "https://cdn.sportmonks.com/images/cricket/leagues/10/10.png")
    ]
}
