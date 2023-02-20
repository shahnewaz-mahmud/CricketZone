//
//  CalendarCollectionViewCell.swift
//  CricketZone
//
//  Created by Shahnewaz on 19/2/23.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 10
        
       
    }

}
