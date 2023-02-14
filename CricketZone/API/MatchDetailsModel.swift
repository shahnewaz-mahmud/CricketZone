//
//  MatchDetailsModel.swift
//  CricketZone
//
//  Created by BJIT on 2/13/23.
//

import Foundation

// MARK: - Welcome
struct MatchDetails: Codable {
    let data: MatchData
}

// MARK: - DataClass
struct MatchData: Codable {
    let id, league_id, season_id, stage_id: Int?
    let round: String?
    let localteam_id, visitorteam_id: Int?
    let starting_at, type: String?
    let live: Bool?
    let status: String?
    let note: String?
    
    let venue_id, toss_won_team_id, winner_team_id: Int?
    let first_umpire_id, second_umpire_id, tv_umpire_id, referee_id: Int?
    let man_of_match_id: Int?
    let total_overs_played: Int?
    let elected: String?
    let superOver, followOn: Bool?
    let league: League?
    let season: Season?
    let localteam, visitorteam: League?
    let runs: [Run]
    let manofmatch: Manofmatch?
    let winnerteam, tosswon: League?
    let venue: Venue?
    let stage: League?
}

// MARK: - League
struct League: Codable {
    let id: Int?
    let season_id, country_id: Int?
    let name, code: String?
    let image_path: String?
    let type: String?
    let national_team: Bool?
    let results: [MatchResult]?
    let league_id: Int?
    let standings: Bool?
}


// MARK: - Result
struct MatchResult: Codable {
    let id, league_id, season_id, stage_id: Int?
    let round: String?
    let localteam_id, visitorteam_id: Int?
    let starting_at: String?
    let type: String?
    let status: String?
    let note: String
    let venueID, tossWonTeamID: Int?
    let winner_team_id: Int?
}

// MARK: - Manofmatch
struct Manofmatch: Codable {
    let id, country_id: Int?
    let firstname, lastname, fullname: String?
    let image_path: String?
    let dateofbirth, gender, battingstyle, bowlingstyle: String?
    let position: Position?
    let updatedAt: String?
}

// MARK: - Position
struct Position: Codable {
    let id: Int?
    let name: String?
}


// MARK: - Season
struct Season: Codable {
    let id, league_id: Int?
    let name, code: String?
}

// MARK: - Venue
struct Venue: Codable {
    let id, country_id: Int?
    let name, city: String?
    let image_path: String?
    let capacity: Int?
    let floodlight: Bool?
}
