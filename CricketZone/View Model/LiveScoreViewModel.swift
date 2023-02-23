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
    
    
    
    func getWinPrediction(matchInfo: MatchData?) -> Int {
        
        guard let matchInfo = matchInfo else {return 50}
        dump(matchInfo)
        
        let localTeamWinRecord = MatchDetailsViewController.matchDetailsViewModel.localTeamWinRecords
        let visitorTeamWinRecord = MatchDetailsViewController.matchDetailsViewModel.visitorTeamWinRecords
        
        guard let localTeamWinRecord = localTeamWinRecord, let visitorTeamWinRecord = visitorTeamWinRecord else {
            return 50
        }
        
        var localTeamScore: Run? = nil
        var visitorTeamScore: Run? = nil
        
        if matchInfo.runs.count == 2 {
            if matchInfo.localteam_id == matchInfo.runs[0].team_id {
                localTeamScore = matchInfo.runs[0]
                visitorTeamScore = matchInfo.runs[1]
            } else {
                localTeamScore = matchInfo.runs[1]
                visitorTeamScore = matchInfo.runs[0]
            }
        } else if matchInfo.runs.count == 1 {
            if matchInfo.localteam_id == matchInfo.runs[0].team_id {
                localTeamScore = matchInfo.runs[0]
            } else {
                visitorTeamScore = matchInfo.runs[0]
            }
        }
        
 
        guard let localTeamScoreData = localTeamScore, let visitorTeamScoreData = visitorTeamScore else {
            return 50
        }
        
       
        let teamAScorePerOver = Double(localTeamScoreData.score ?? 0) / (localTeamScoreData.overs ?? 1)
        let teamBScorePerOver = Double(visitorTeamScoreData.score ?? 0) / (visitorTeamScoreData.overs ?? 1)
        
        
        let teamAConsecutiveWins = countConsecutiveWins(lastWinValues: localTeamWinRecord)
        let teamBConsecutiveWins = countConsecutiveWins(lastWinValues: visitorTeamWinRecord)
        
     
        var winProbability = 50
        if teamAScorePerOver > teamBScorePerOver {
            winProbability += 10
        }
        if teamAConsecutiveWins > teamBConsecutiveWins {
            winProbability += 10
        }
        return winProbability
    }

    func countConsecutiveWins(lastWinValues: [Bool]) -> Int {
        var consecutiveWins = 0
        for i in stride(from: lastWinValues.count - 1, through: 0, by: -1) {
            if lastWinValues[i] {
                consecutiveWins += 1
            } else {
                break
            }
        }
        return consecutiveWins
    }
}
