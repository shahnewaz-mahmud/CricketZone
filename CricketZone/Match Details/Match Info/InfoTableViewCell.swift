//
//  InfoTableViewCell.swift
//  CricketZone
//
//  Created by BJIT on 2/13/23.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var cellImageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cellImageWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.layer.cornerRadius = 20
        cellBackgroundView.dropShadow()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
