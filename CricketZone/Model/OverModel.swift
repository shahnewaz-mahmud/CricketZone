//
//  OverModel.swift
//  CricketZone
//
//  Created by Shahnewaz on 23/2/23.
//

import Foundation

// MARK: - BallList
struct Overs: Codable {
    let data: ballList?
}

// MARK: - ballList
struct ballList: Codable  {
    let balls: [Ball]?
}

// MARK: - Ball
struct Ball: Codable  {
    let id, fixture_id, team_id: Int?
    let ball: Double?
    let batsman, bowler, batsmantwo: Player?
    let score: Score?
    let team: Team?
}


// MARK: - Score
struct Score: Codable  {
    let id: Int?
    let name: String?
    let runs: Int?
    let four, six: Bool?
    let bye, leg_bye, noball, noball_runs: Int?
    let is_wicket, ball, out: Bool?
}


struct Over: Codable  {
    var balls: [Ball]?
}
