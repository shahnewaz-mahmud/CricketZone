//
//  TeamFormTVHeaderFooterView.swift
//  CricketZone
//
//  Created by BJIT on 2/14/23.
//

import UIKit

class TeamFormTVHeaderFooterView: UITableViewHeaderFooterView {
    
    
    

    @IBOutlet weak var teamFormLabel: UILabel!

    @IBOutlet weak var xibBackground: UIView!
    
    
    @IBOutlet weak var r1Icon: UIImageView!
    
    @IBOutlet weak var r2Icon: UIImageView!
    
    
    @IBOutlet weak var r3Icon: UIImageView!
    
    @IBOutlet weak var r4Icon: UIImageView!
    
    @IBOutlet weak var r5Icon: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    
    @IBOutlet weak var expandButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibBackground.layer.cornerRadius = 20
        xibBackground.dropShadow()
        expandButton.isHidden = true
       
    }
    
}
