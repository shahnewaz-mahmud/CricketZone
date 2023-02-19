//
//  WinProbabilityTableViewCell.swift
//  CricketZone
//
//  Created by Shahnewaz on 18/2/23.
//

import UIKit

class WinProbabilityTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var progressBarBackground: UIView!
    
    @IBOutlet weak var progressBar: UIView!
    
    @IBOutlet weak var team1Flag: UIImageView!
    
    @IBOutlet weak var team1Name: UILabel!
    
    @IBOutlet weak var team2Flag: UIImageView!
    
    @IBOutlet weak var team2Name: UILabel!
    
    
    @IBOutlet weak var team2Probability: UILabel!
    
    @IBOutlet weak var team1Probability: UILabel!
    
    @IBOutlet weak var cellbackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        progressBarBackground.layer.cornerRadius = 5
        cellbackground.layer.cornerRadius = 25
        team2Flag.layer.cornerRadius = 5
        team1Flag.layer.cornerRadius = 5
        //cellbackground.dropShadow()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
