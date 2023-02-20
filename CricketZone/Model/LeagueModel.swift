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
    let img_path: String?
}

extension LeagueInfo {
    static let LeagueInfoList = [
        LeagueInfo(id: 3, name: "T20I", img_path: "https://cdn.sportmonks.com/images/cricket/leagues/3/3.png"),
        LeagueInfo(id: 5, name: "BBL", img_path: "https://cdn.sportmonks.com/images/cricket/leagues/5/5.png"),
        LeagueInfo(id: 10, name: "T20C", img_path: "https://cdn.sportmonks.com/images/cricket/leagues/10/10.png")
    ]
}
