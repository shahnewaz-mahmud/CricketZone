//
//  MatchDetailsViewController.swift
//  CricketZone
//
//  Created by Shahnewaz on 11/2/23.
//

import UIKit

class MatchDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var LeagueName: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var team1Flag: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team1Over: UILabel!
    @IBOutlet weak var team2Flag: UIImageView!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var team2Over: UILabel!
    @IBOutlet weak var ContentView: UIView!
    
    @IBOutlet weak var matchInfoSegment: UIView!
    @IBOutlet weak var scoreCardSegment: UIView!
    @IBOutlet weak var overDetailsSegment: UIView!
    @IBOutlet weak var matchSquadSegment: UIView!
    
    
    @IBOutlet weak var matchInfoBtnIcon: UIButton!
    @IBOutlet weak var matchInfoBtnText: UILabel!
    
    
    @IBOutlet weak var scoreCardBtnIcon: UIButton!
    @IBOutlet weak var scoreCardBtnText: UILabel!
    
    @IBOutlet weak var overDetailsBtnIncon: UIButton!
    @IBOutlet weak var overDetailsBtnText: UILabel!
    
    @IBOutlet weak var matchSquadBtnIcon: UIButton!
    @IBOutlet weak var matchSquadBtnText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        team1Flag.layer.cornerRadius = team1Flag.frame.height/2
        team2Flag.layer.cornerRadius = team2Flag.frame.height/2
        ContentView.layer.cornerRadius = 35
    }
    
    
    @IBAction func matchInfoBtnAction(_ sender: Any) {
        matchInfoSegment.alpha = 1
        scoreCardSegment.alpha = 0
        overDetailsSegment.alpha = 0
        matchSquadSegment.alpha = 0
        
        matchInfoBtnIcon.tintColor = UIColor(named: "Secondary Dual Mode")
        matchInfoBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        scoreCardBtnIcon.tintColor = .systemGray2
        scoreCardBtnText.tintColor = .systemGray2
        overDetailsBtnIncon.tintColor = .systemGray2
        overDetailsBtnText.tintColor = .systemGray2
        matchSquadBtnIcon.tintColor = .systemGray2
        matchSquadBtnText.tintColor = .systemGray2
    }
    
    
    @IBAction func scoreCardbtnAction(_ sender: Any) {
        matchInfoSegment.alpha = 0
        scoreCardSegment.alpha = 1
        overDetailsSegment.alpha = 0
        matchSquadSegment.alpha = 0
        
        scoreCardBtnIcon.tintColor = UIColor(named: "Secondary Dual Mode")
        scoreCardBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        matchInfoBtnIcon.tintColor = .systemGray2
        matchInfoBtnText.tintColor = .systemGray2
        overDetailsBtnIncon.tintColor = .systemGray2
        overDetailsBtnText.tintColor = .systemGray2
        matchSquadBtnIcon.tintColor = .systemGray2
        matchSquadBtnText.tintColor = .systemGray2
        
        
        
    }
    
    
    @IBAction func overDetailsBtnAction(_ sender: Any) {
        matchInfoSegment.alpha = 0
        scoreCardSegment.alpha = 0
        overDetailsSegment.alpha = 1
        matchSquadSegment.alpha = 0
        
        overDetailsBtnIncon.tintColor = UIColor(named: "Secondary Dual Mode")
        overDetailsBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        matchInfoBtnIcon.tintColor = .systemGray2
        matchInfoBtnText.tintColor = .systemGray2
        scoreCardBtnIcon.tintColor = .systemGray2
        scoreCardBtnText.tintColor = .systemGray2
        matchSquadBtnIcon.tintColor = .systemGray2
        matchSquadBtnText.tintColor = .systemGray2
    }
    
    
    @IBAction func matchSquadBtnAction(_ sender: Any) {
        matchInfoSegment.alpha = 0
        scoreCardSegment.alpha = 0
        overDetailsSegment.alpha = 0
        matchSquadSegment.alpha = 1
        
        matchSquadBtnIcon.tintColor = UIColor(named: "Secondary Dual Mode")
        matchSquadBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        matchInfoBtnIcon.tintColor = .systemGray2
        matchInfoBtnText.tintColor = .systemGray2
        scoreCardBtnIcon.tintColor = .systemGray2
        scoreCardBtnText.tintColor = .systemGray2
        overDetailsBtnIncon.tintColor = .systemGray2
        overDetailsBtnText.tintColor = .systemGray2
    }
    

}
