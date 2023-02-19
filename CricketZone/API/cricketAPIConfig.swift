//
//  cricketAPIConfig.swift
//  CricketZone
//
//  Created by BJIT on 2/10/23.
//

import Foundation

final class cricketAPIConfig {
    
    private init() {}
    
    private static let apiBaseURL = "https://cricket.sportmonks.com/api/v2.0"
    private static let apiKey = "qgcaTr1JcWOsR9trRy8ScGLyoGLnnVZDMo31Ax2EB52W74FYxCQ3EPjBGsr0"
    
    static var apiGetUpcomingMatchURL: URL? {
        guard let apiURL = URL(string: apiBaseURL) else {
            return nil
        }
        var components = URLComponents(url: apiURL, resolvingAgainstBaseURL: false)
        components?.path += "/fixtures"
        components?.queryItems = [
            URLQueryItem(name: "include", value: "runs,localteam,visitorteam"),
            URLQueryItem(name: "filter[status]", value: "NS"),
            URLQueryItem(name: "sort", value: "starting_at"),
            URLQueryItem(name: "fields[teams]", value: "code,image_path"),
            URLQueryItem(name: "api_token", value: apiKey)
        ]
        guard let url = components?.url else { return nil }
        return url
    }
    
    static var apiGetLiveMatchURL: URL? {
        guard let apiURL = URL(string: apiBaseURL) else {
            return nil
        }
        var components = URLComponents(url: apiURL, resolvingAgainstBaseURL: false)
        components?.path += "/livescores"
        components?.queryItems = [
            URLQueryItem(name: "include", value: "runs,localteam,visitorteam"),
            URLQueryItem(name: "api_token", value: apiKey)
        ]
        guard let url = components?.url else { return nil }
        return url
    }
    
    
    static var apiGetRecentMatchURL: URL? {
        guard let apiURL = URL(string: apiBaseURL) else {
            return nil
        }
        var components = URLComponents(url: apiURL, resolvingAgainstBaseURL: false)
        components?.path += "/fixtures"
        components?.queryItems = [
            URLQueryItem(name: "include", value: "runs,localteam,visitorteam"),
            URLQueryItem(name: "filter[status]", value: "Finished"),
            URLQueryItem(name: "fields[teams]", value: "code,image_path"),
            URLQueryItem(name: "sort", value: "-starting_at"),
            URLQueryItem(name: "api_token", value: apiKey)
        ]
        guard let url = components?.url else { return nil }
        return url
    }
    
    static var apiGetAllPlayersURL: URL? {
        guard let apiURL = URL(string: apiBaseURL) else {
            return nil
        }
        var components = URLComponents(url: apiURL, resolvingAgainstBaseURL: false)
        components?.path += "/players"
        components?.queryItems = [
            URLQueryItem(name: "fields[teams]", value: "fullname,image_path"),
            URLQueryItem(name: "api_token", value: apiKey)
        ]
        guard let url = components?.url else { return nil }
        return url
    }
    
    static func getMatchDetailsAPIUrl(matchId: Int) -> URL?{
        var apiGetMatchDetailsURL: URL? {
            guard let apiURL = URL(string: apiBaseURL) else {
                return nil
            }
            var components = URLComponents(url: apiURL, resolvingAgainstBaseURL: false)
            components?.path += "/fixtures"
            components?.path += "/\(matchId)"
            components?.queryItems = [
                URLQueryItem(name: "include", value: "runs,localteam,visitorteam,league, stage,season,venue,tosswon,winnerteam,manofmatch,localteam.results,visitorteam.results,batting.result, batting.batsman, bowling.bowler,lineup"),
                URLQueryItem(name: "api_token", value: apiKey)
            ]
            guard let url = components?.url else { return nil }
            return url
        }
        return apiGetMatchDetailsURL
    }
    
    static func getPlayerDetailsAPIUrl(playerId: Int) -> URL?{
        var apiGetPlayerDetailsURL: URL? {
            guard let apiURL = URL(string: apiBaseURL) else {
                return nil
            }
            var components = URLComponents(url: apiURL, resolvingAgainstBaseURL: false)
            components?.path += "/players"
            components?.path += "/\(playerId)"
            components?.queryItems = [
                URLQueryItem(name: "include", value: "career,country,teams,currentteams, career.season"),
                URLQueryItem(name: "api_token", value: apiKey)
            ]
            guard let url = components?.url else { return nil }
            return url
        }
        return apiGetPlayerDetailsURL
    }
   
}
