//
//  RankTableViewCell.swift
//  CricketZone
//
//  Created by Admin on 20/2/23.
//

import UIKit

class RankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    
    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var ratings: UILabel!
    
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBackground.layer.cornerRadius = 20
        cellBackground.dropShadow()
        
        teamImage.layer.cornerRadius = teamImage.frame.width/2
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
   
    
}
