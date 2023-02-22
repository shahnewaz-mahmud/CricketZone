//
//  PlayerStatsViewModel.swift
//  CricketZone
//
//  Created by Admin on 22/2/23.
//

import Foundation

class PlayerStatsViewModel {
    
    @Published var playerStats: [String: Double]?
    
    func getPlayerStats(playerCareer: [Career]?, category: String) {
        
        
        guard let playerCareer = playerCareer else {return}
        
       
        dump(playerCareer)
        
        var battingTotalRun = 0.0
        var battingTotalMatch = 0.0
        var battingTotal50s = 0.0
        var battingTotal100s = 0.0
        var battingHighestRun = 0.0
        var battingTotalStrikeRate = 0.0
        
        var bowlingTotalMatch = 0.0
        var bowlingTotalOvers = 0.0
        var bowlingTotalEconRate = 0.0
        var bowlingTotalRuns = 0.0
        var bowlingTotalWickets = 0.0
        var counter = 0.0
        
        var statistics : [String:Double] = [:]
        
        
        if !playerCareer.isEmpty {
            
            for i in 0...playerCareer.count - 1 {
                
                if playerCareer[i].type == category {
                    if let run = playerCareer[i].batting?["runs_scored"],
                       let match = playerCareer[i].batting?["matches"],
                       let fifties = playerCareer[i].batting?["fifties"],
                       let hundreds = playerCareer[i].batting?["hundreds"],
                       let highestInningsRun = playerCareer[i].batting?["highest_inning_score"],
                       let strikeRate = playerCareer[i].batting?["strike_rate"] {
                        battingTotalRun = battingTotalRun + run
                        battingTotalMatch = battingTotalMatch + match
                        battingTotal50s = battingTotal50s + fifties
                        battingTotal100s = battingTotal100s + hundreds
                        battingTotalStrikeRate = battingTotalStrikeRate + strikeRate
                        
                        if (highestInningsRun > battingHighestRun) {
                            battingHighestRun = highestInningsRun
                        }
                        
                        counter = counter + 1
                    }
                    
                    
                    if let match = playerCareer[i].bowling?["matches"],
                       let overs = playerCareer[i].bowling?["overs"],
                       let econRate = playerCareer[i].bowling?["econ_rate"],
                       let runs = playerCareer[i].bowling?["runs"],
                       let wickets = playerCareer[i].bowling?["wickets"] {
                        
                        bowlingTotalMatch = bowlingTotalMatch + match
                        bowlingTotalOvers = bowlingTotalOvers + overs
                        bowlingTotalEconRate = bowlingTotalEconRate + econRate
                        bowlingTotalRuns = bowlingTotalRuns + runs
                        bowlingTotalWickets = bowlingTotalWickets + wickets
                        
                    }
                    
                    statistics["battingTotalRun"] = battingTotalRun
                    statistics["battingTotalMatch"] = battingTotalMatch
                    statistics["battingTotal50s"] = battingTotal50s
                    statistics["battingTotal100s"] = battingTotal100s
                    statistics["battingHighestRun"] = battingHighestRun
                    statistics["battingTotalStrikeRate"] = battingTotalStrikeRate/counter
                    
                    statistics["bowlingTotalMatch"] = bowlingTotalMatch
                    statistics["bowlingTotalOvers"] = bowlingTotalOvers
                    statistics["bowlingTotalEconRate"] = bowlingTotalEconRate/counter
                    statistics["bowlingTotalRuns"] = bowlingTotalRuns
                    statistics["bowlingTotalWickets"] = bowlingTotalWickets
                }  
            }
            
            
            playerStats = statistics
            
            print(playerStats)
            
           
            
        
            
            
        }
        
  
       
    }
    
}
