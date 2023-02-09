//
//  Shared.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import Foundation
import UIKit

class RoundedTabBar: UITabBar {
    override func draw(_ rect: CGRect) {
        let inset: CGFloat = 3
        let safeAreaInsets = self.safeAreaInsets
        let height = self.bounds.height - safeAreaInsets.bottom + 2
        let insetBounds = CGRect(x: 6 * inset, y: inset, width: self.bounds.width - 12 * inset, height: height - 2 * inset)
        let path = UIBezierPath(roundedRect: insetBounds, cornerRadius: 14)
        
        let darkPurple = UIColor(named: "Secondary Color")
        darkPurple?.setFill()
        path.fill()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            let safeAreaInsets = self.safeAreaInsets
            let height = self.bounds.height - safeAreaInsets.bottom
            var tabBarItemIndex = 0
        for _ in self.items! {
                let tabBarButton = self.subviews[tabBarItemIndex]
                let y = (height - tabBarButton.bounds.height) / 2 + 6
                tabBarButton.frame = CGRect(x: tabBarButton.frame.origin.x, y: y, width: tabBarButton.bounds.width, height: tabBarButton.bounds.height)
                tabBarItemIndex += 1
            }
        }

}

extension UIView {
    /// show drop shadow under view
    /// - Parameter scale: bool variable to enable scaling
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1

    }
}

