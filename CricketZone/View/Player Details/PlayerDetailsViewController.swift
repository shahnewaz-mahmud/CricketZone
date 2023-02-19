//
//  PlayerDetailsViewController.swift
//  CricketZone
//
//  Created by Admin on 16/2/23.
//

import UIKit
import Combine

class PlayerDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var contentViewBackground: UIView!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerFlag: UIImageView!
    
    @IBOutlet weak var playerOverviewSegment: UIView!
    @IBOutlet weak var playerTeamsSegment: UIView!
    @IBOutlet weak var playerCareerSegment: UIView!
    @IBOutlet weak var playerStatsSegment: UIView!
    
    
    @IBOutlet weak var playerOverviewBtn: UIButton!
    @IBOutlet weak var playerOverviewBtnText: UILabel!
    
    @IBOutlet weak var playerTeamsBtn: UIButton!
    @IBOutlet weak var playerTeamsBtnText: UILabel!
    
    @IBOutlet weak var playerCareerBtn: UIButton!
    @IBOutlet weak var playerCareerBtnText: UILabel!
    
    @IBOutlet weak var playerStatsBtn: UIButton!
    @IBOutlet weak var playerStatsBtnText: UILabel!
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerImage.layer.cornerRadius = playerImage.frame.width/2
        contentViewBackground.layer.cornerRadius = 35
        setupBinder()
        showPlayerOverViewSegment()
        
    }
    
    
    
    func setupBinder() {
        PlayerDetailsViewModel.shared.$playerDetails.sink { [weak self] playerDetails in
            
            guard let self = self else {return}
            guard let playerDetails = playerDetails else {return}
            
            
            DispatchQueue.main.async {
                self.playerName.text = playerDetails.fullname
                self.playerImage.sd_setImage(
                    with: URL(string: playerDetails.image_path ?? ""),
                    placeholderImage: UIImage(named: "player")
                )
                self.playerFlag.sd_setImage(
                    with: URL(string: playerDetails.country?.image_path ?? ""),
                    placeholderImage: UIImage(named: "f2")
                )
                
                self.playerPosition.text = (playerDetails.position?.name ?? "") + " | " + (playerDetails.country?.name ?? "")
            }
            
        }.store(in: &cancellables)
    }
    
    func showPlayerOverViewSegment() {
        playerOverviewSegment.alpha = 1
        playerTeamsSegment.alpha = 0
        playerCareerSegment.alpha = 0
        playerStatsSegment.alpha = 0
    }
    
    
    @IBAction func playerOverviewBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
            self.playerOverviewSegment.alpha = 1
            self.playerTeamsSegment.alpha = 0
            self.playerCareerSegment.alpha = 0
            self.playerStatsSegment.alpha = 0
        })
        
        playerOverviewBtn.tintColor = UIColor(named: "Secondary Dual Mode")
        playerOverviewBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        playerTeamsBtn.tintColor = .systemGray2
        playerTeamsBtnText.tintColor = .systemGray2
        playerCareerBtn.tintColor = .systemGray2
        playerCareerBtnText.tintColor = .systemGray2
        playerStatsBtn.tintColor = .systemGray2
        playerStatsBtnText.tintColor = .systemGray2
        
    }
    
    @IBAction func playerTeamsBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
            self.playerOverviewSegment.alpha = 0
            self.playerTeamsSegment.alpha = 1
            self.playerCareerSegment.alpha = 0
            self.playerStatsSegment.alpha = 0
        })
        
        playerTeamsBtn.tintColor = UIColor(named: "Secondary Dual Mode")
        playerTeamsBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        playerOverviewBtn.tintColor = .systemGray2
        playerOverviewBtnText.tintColor = .systemGray2
        playerCareerBtn.tintColor = .systemGray2
        playerCareerBtnText.tintColor = .systemGray2
        playerStatsBtn.tintColor = .systemGray2
        playerStatsBtnText.tintColor = .systemGray2
    }
    
    @IBAction func playerCareerBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
            self.playerOverviewSegment.alpha = 0
            self.playerTeamsSegment.alpha = 0
            self.playerCareerSegment.alpha = 1
            self.playerStatsSegment.alpha = 0
        })
        
        playerCareerBtn.tintColor = UIColor(named: "Secondary Dual Mode")
        playerCareerBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        playerOverviewBtn.tintColor = .systemGray2
        playerOverviewBtnText.tintColor = .systemGray2
        playerTeamsBtn.tintColor = .systemGray2
        playerTeamsBtnText.tintColor = .systemGray2
        playerStatsBtn.tintColor = .systemGray2
        playerStatsBtnText.tintColor = .systemGray2
    }
    
    @IBAction func playerStatsBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            guard let self = self else {return}
            self.view.layoutIfNeeded()
            self.playerOverviewSegment.alpha = 0
            self.playerTeamsSegment.alpha = 0
            self.playerCareerSegment.alpha = 0
            self.playerStatsSegment.alpha = 1
        })
        
        playerStatsBtn.tintColor = UIColor(named: "Secondary Dual Mode")
        playerStatsBtnText.textColor = UIColor(named: "Secondary Dual Mode")
        
        playerOverviewBtn.tintColor = .systemGray2
        playerOverviewBtnText.tintColor = .systemGray2
        playerTeamsBtn.tintColor = .systemGray2
        playerTeamsBtnText.tintColor = .systemGray2
        playerCareerBtn.tintColor = .systemGray2
        playerCareerBtnText.tintColor = .systemGray2
    }
    

}
