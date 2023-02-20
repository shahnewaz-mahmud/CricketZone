//
//  Player.swift
//  CricketZone
//
//  Created by Admin on 20/2/23.
//

import Foundation

struct PlayerList: Codable, Sequence {
    let data: [PlayerInfo]?

    func makeIterator() -> PlayerIterator {
        return PlayerIterator(data: data)
    }

    struct PlayerIterator: IteratorProtocol {
        let data: [PlayerInfo]?
        var currentIndex = 0

        init(data: [PlayerInfo]?) {
            self.data = data
        }

        mutating func next() -> PlayerInfo? {
            guard let data = data, currentIndex < data.count else {
                return nil
            }

            let result = data[currentIndex]
            currentIndex += 1
            return result
        }
    }
}

// MARK: - Datum
struct PlayerInfo: Codable {
    let id: Int?
    let fullname: String?
    let image_path: String?
}
