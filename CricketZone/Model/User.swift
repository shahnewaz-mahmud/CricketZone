//
//  User.swift
//  CricketZone
//
//  Created by Admin on 23/2/23.
//

import Foundation

struct User: Encodable, Decodable {
    var isDarkmode: Bool
    var lastNotificationSet: Date
}
