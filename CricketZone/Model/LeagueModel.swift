//
//  LeagueModel.swift
//  CricketZone
//
//  Created by Shahnewaz on 19/2/23.
//

import Foundation


struct LeagueInfo {
    let name: String?
    let img_path: String?
}

extension LeagueInfo {
    static let LeagueInfoList = [
        LeagueInfo(name: "T20I", img_path: "https://cdn.sportmonks.com/images/cricket/leagues/3/3.png"),
        LeagueInfo(name: "BBL", img_path: "https://cdn.sportmonks.com/images/cricket/leagues/5/5.png"),
        LeagueInfo(name: "T20C", img_path: "https://cdn.sportmonks.com/images/cricket/leagues/10/10.png")
    ]
}
