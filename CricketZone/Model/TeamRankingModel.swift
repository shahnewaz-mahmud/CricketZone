//
//  TeamRankingModel.swift
//  CricketZone
//
//  Created by Shahnewaz on 21/2/23.
//

import Foundation


// MARK: - TeamRanking
struct TeamRanking: Codable {
    let data: [RankData]?
}

// MARK: - RankData
struct RankData: Codable {
    let type: String?
    let gender: String?
    let team: [TeamDetails]?
}

// MARK: - Team
struct TeamDetails: Codable {
    let id: Int?
    let name, code: String?
    let image_path: String?
    let country_id: Int?
    let national_team: Bool?
    let position: Int?
    let ranking: Ranking?
}

// MARK: - Ranking
struct Ranking: Codable{
    let position, matches, points, rating: Int?
}
