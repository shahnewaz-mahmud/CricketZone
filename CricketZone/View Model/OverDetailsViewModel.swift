//
//  OverDetailsViewModel.swift
//  CricketZone
//
//  Created by Admin on 23/2/23.
//

import Foundation

class OverDetailsViewModel {
    
    @Published var teamOverList: [Int : [Ball]]?

    func getOverList(teamId: Int, balls: [Ball]) {
        var overList: [Int : [Ball]] = [:]
        
        if !balls.isEmpty {
            var prevOverNum = 0.0
            var ballsArray: [Ball] = []
            for i in 0...balls.count - 1 {
                if balls[i].team_id == teamId {
                    // Check if it's a new over
                    let (overNum, _) = splitDouble(balls[i].ball ?? 0.0)
                    
                    if prevOverNum < overNum {
                        overList[Int(prevOverNum)] = ballsArray
                        prevOverNum = overNum
                        ballsArray.removeAll()
                        ballsArray.append(balls[i])
                    } else {
                        prevOverNum = overNum
                        ballsArray.append(balls[i])
                    }
                }
            }
            
            teamOverList = overList
        }

        
    }
    
    
    func splitDouble(_ input: Double) -> (Double, Double) {
        let integerPart = floor(input)
        let fractionalPart = input - integerPart
        return (integerPart, fractionalPart)
    }

    
}
