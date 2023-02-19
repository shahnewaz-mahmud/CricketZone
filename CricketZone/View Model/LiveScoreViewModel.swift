//
//  LiveScoreViewModel.swift
//  CricketZone
//
//  Created by Shahnewaz on 18/2/23.
//

import Foundation

class LiveScoreViewModel {
    @Published var liveBattingDetails: [Batting]?
    @Published var liveBowlingDetails: [Bowling]?
    
    
    func prepareLiveScoreData(matchData: MatchData){
        
        guard let matchData = MatchDetailsViewController.matchDetailsViewModel.matchDetails else {return}
        
        var teamBatting: [Batting] = []
        var teamBowling: [Bowling] = []
        
        var battingTeamId = 0

        if !matchData.batting.isEmpty {
            for i in 0...(matchData.batting.count - 1) {
                if matchData.batting[i].active == true {
                    battingTeamId = matchData.batting[i].team_id ?? 0
                }

            }
            
            for i in 0...(matchData.batting.count - 1) {
                if matchData.batting[i].team_id == battingTeamId && matchData.batting[i].result?.name == "Not Out" {
                    teamBatting.append(matchData.batting[i])
                }
            }
            
            for i in 0...(matchData.bowling.count - 1) {
                if matchData.bowling[i].team_id != battingTeamId {
                    
                    if isFractional(matchData.bowling[i].overs ?? 0.0) == true {
                        teamBowling.append(matchData.bowling[i])
                    }
                }
            }
        }

        
        liveBattingDetails = teamBatting
        liveBowlingDetails = teamBowling
    }
    
    
    func isFractional(_ num: Double) -> Bool {
        return num.truncatingRemainder(dividingBy: 1) != 0
    }
}
