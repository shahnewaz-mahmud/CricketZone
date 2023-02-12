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
            URLQueryItem(name: "fields[fixtures]", value: "id,type,starting_at"),
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
            URLQueryItem(name: "fields[fixtures]", value: "id,type,note,starting_at"),
            URLQueryItem(name: "sort", value: "-starting_at"),
            URLQueryItem(name: "api_token", value: apiKey)
        ]
        guard let url = components?.url else { return nil }
        return url
    }
    
    
}
