//
//  ScoreCardTVHeaderView.swift
//  CricketZone
//
//  Created by BJIT on 2/15/23.
//

import UIKit

class ScoreCardTVHeaderView: UITableViewHeaderFooterView {
    
    
    @IBOutlet weak var headerBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerBackground.layer.cornerRadius = 10
        headerBackground.dropShadow()
       
       
    }
    

}
