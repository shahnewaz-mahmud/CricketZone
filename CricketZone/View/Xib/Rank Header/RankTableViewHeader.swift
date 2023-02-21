//
//  RankTableViewHeader.swift
//  CricketZone
//
//  Created by Shahnewaz on 21/2/23.
//

import UIKit

class RankTableViewHeader: UITableViewHeaderFooterView {


    
    @IBOutlet weak var headerBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()

        headerBackground.layer.cornerRadius = 15
        headerBackground.dropShadow()
    }
    
}
