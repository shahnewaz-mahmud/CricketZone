//
//  PlayerTeamUITableViewHeaderView.swift
//  CricketZone
//
//  Created by Admin on 17/2/23.
//

import UIKit

class PlayerTeamUITableViewHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var headerBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerBackground.layer.cornerRadius = 5
        //headerBackground.dropShadow()
    }
}
