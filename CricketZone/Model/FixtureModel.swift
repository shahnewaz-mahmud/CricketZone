//
//  FixtureModel.swift
//  CricketZone
//
//  Created by BJIT on 2/10/23.
//

import Foundation

// MARK: - LiveMatch
struct MatchList: Codable {
    let data: [Match]?
}

// MARK: - Match
struct Match: Codable {
    let id: Int?
    let starting_at: String?
    let type: String?
    let live: Bool?
    let status: String?
    let note: String?
    let localteam_id, visitorteam_id: Int?
    let localteam: Team?
    let visitorteam: Team?
    let runs: [Run]
}

// MARK: - Team
struct Team: Codable {
    let id: Int?
    let code: String?
    let image_path: String?
}

struct Run: Codable {
    let id, fixture_id, team_id, inning: Int?
    let score, wickets: Int?
    let overs: Double?
}

