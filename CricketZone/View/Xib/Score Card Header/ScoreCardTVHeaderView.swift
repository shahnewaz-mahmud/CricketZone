//
//  ScoreCardTVHeaderView.swift
//  CricketZone
//
//  Created by BJIT on 2/15/23.
//

import UIKit

class ScoreCardTVHeaderView: UITableViewHeaderFooterView {
    
    
    @IBOutlet weak var headerBackground: UIView!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var scoreType1: UILabel!
    @IBOutlet weak var scoreType2: UILabel!
    @IBOutlet weak var scoreType3: UILabel!
    @IBOutlet weak var scoreType4: UILabel!
    @IBOutlet weak var scoreType5: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerBackground.layer.cornerRadius = 10
        headerBackground.dropShadow()
    }

}
