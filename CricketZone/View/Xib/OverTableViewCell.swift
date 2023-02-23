//
//  OverTableViewCell.swift
//  CricketZone
//
//  Created by Admin on 23/2/23.
//

import UIKit

class OverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    
    @IBOutlet weak var overNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 10
        cellBackground.dropShadow()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
