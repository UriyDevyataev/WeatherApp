//
//  Extensions.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 04.01.2022.
//

import Foundation
import UIKit

// MARK: - UIView
extension UIView {
    
    func cornerHalfHeight(){
        corner(withRadius: frame.height / 2)
    }
    
    func cornerHalfWidth(){
        corner(withRadius: frame.width / 2)
    }
    
    func corner(withRadius: CGFloat) {
        layer.cornerRadius = withRadius
        layer.sublayers?.forEach{ $0.cornerRadius = withRadius}
        if self is UIImageView || self is UITextField || self is UILabel {
            clipsToBounds = true
        }
    }
}

// MARK: - Int
extension Int {
    
    func strDateFromUTC() -> String {
        let unixTime = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        let str = formatter.string(from: unixTime)
        let strArr = str.components(separatedBy: ", ")
        return "\(strArr[0])\n\(strArr[1])"
    }
    
    func strHourFromUTC() -> String {
        let unixTime = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let str = formatter.string(from: unixTime)
        return str
    }
    
    func strDayFromUTC() -> String {
        let unixTime = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "EE d"
        
        let strUnixTime = formatter.string(from: unixTime)
        let strNowTime = formatter.string(from: Date())
        
        if strUnixTime == strNowTime {
            return "Сегодня"
        } else {
            formatter.dateFormat = "EE"
            return formatter.string(from: unixTime)
        }
    }
}

// MARK: - Double
extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func rounded() -> Int {
        let divisor = pow(10.0, Double(0))
        let d = (self * divisor).rounded() / divisor
        return Int(d)
    }
}
