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
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var playerFlag: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerImage.layer.cornerRadius = playerImage.frame.width/2
        contentViewBackground.layer.cornerRadius = 35
        setupBinder()
        
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


}
