//
//  ScoreCardViewModel.swift
//  CricketZone
//
//  Created by BJIT on 2/15/23.
//

import Foundation

class ScoreCardViewModel {
    @Published var localTeamBattingDetails: [Batting]?
    @Published var localTeamBowlingDetails: [Bowling]?
    @Published var visitorTeamBattingDetails: [Batting] = []
    @Published var visitorTeamBowlingDetails: [Bowling] = []
    
    func prepareTeamWiseScoreData(){
        
        guard let matchData = MatchDetailsViewController.matchDetailsViewModel.matchDetails else {return}
        
        var localTeamBatting: [Batting] = []
        var visitorTeamBatting: [Batting] = []
        var localTeamBowling: [Bowling] = []
        var visitorTeamBowling: [Bowling] = []

        
        for i in 0...(matchData.batting.count - 1) {
            if matchData.localteam?.id == matchData.batting[i].team_id {
                localTeamBatting.append(matchData.batting[i])
            } else {
                visitorTeamBatting.append(matchData.batting[i])
            }
        }
        
        for i in 0...(matchData.bowling.count - 1) {
            if matchData.localteam?.id == matchData.bowling[i].team_id {
                localTeamBowling.append(matchData.bowling[i])
            } else {
                visitorTeamBowling.append(matchData.bowling[i])
            }
        }
        
        
        localTeamBattingDetails = localTeamBatting
        visitorTeamBattingDetails = visitorTeamBatting
        localTeamBowlingDetails = localTeamBowling
        visitorTeamBowlingDetails = visitorTeamBowling
    }
}
