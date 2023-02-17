//
//  Shared.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import Foundation
import UIKit

 class Shared {
   
     func getReadableDateTime(data: String) -> (String, String) {
         let dateString = data
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
         guard let date = dateFormatter.date(from: dateString) else {
             print("Invalid date format")
             return ("", "")
         }

         let calendar = Calendar.current
         let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
         let month = calendar.monthSymbols[dateComponents.month! - 1]
         
         dateFormatter.dateFormat = "h:mm a"
         dateFormatter.amSymbol = "AM"
         dateFormatter.pmSymbol = "PM"

         let time = dateFormatter.string(from: date)
         let readableDate = "\(dateComponents.day!) \(month)"
         
         return (time, readableDate)
     }
     
     func calculateAge(birthdateString: String) -> String? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         if let birthdate = dateFormatter.date(from: birthdateString) {
             let now = Date()
             let ageComponents = Calendar.current.dateComponents([.year], from: birthdate, to: now)
             return String(ageComponents.year ?? 0)
         }
         return nil
     }

}


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
        layer.shadowOpacity = 0.20
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1

    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}


