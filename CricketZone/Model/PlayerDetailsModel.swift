//
//  PlayerDetailsModel.swift
//  CricketZone
//
//  Created by Admin on 16/2/23.
//

import Foundation

// MARK: - PlayerDetails
struct PlayerDetails: Codable {
    let data: Player?
}

// MARK: - DataClass
struct Player: Codable {
    let id, country_id: Int?
    let firstname, lastname, fullname: String?
    let image_path: String?
    let dateofbirth, gender, battingstyle: String?
    let bowlingstyle: String?
    let position: Position?
    let country: Country?
    let career: [Career]?
    let teams: [TeamInfo]?
    let currentteams: [TeamInfo]?
}

// MARK: - Career
struct Career: Codable {
    let type: String?
    let season_id, player_id: Int?
    let bowling, batting: [String: Double]?
    let season: Season?
}


// MARK: - Country
struct Country: Codable {
    let id, continent_id: Int?
    let name: String?
    let image_path: String?
}


// MARK: - Team
struct TeamInfo: Codable {
    let id: Int?
    let name, code: String?
    let image_path: String?
    let country_id: Int?
    let national_team: Bool?
    let inSquad: InSquad?
}

// MARK: - InSquad
struct InSquad: Codable {
    let seasonID, leagueID: Int?
}
