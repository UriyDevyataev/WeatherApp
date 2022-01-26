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
        if self is UIImageView || self is UITextField || self is UILabel {
            clipsToBounds = true
        }
    }
    
    func cornerAll(withRadius: CGFloat) {
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
    
    func strTimeFromUTC() -> String {
        let unixTime = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let str = formatter.string(from: unixTime)
        return str
    }
    
    func strHourFromUTC() -> String {
        let unixTime = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let str = formatter.string(from: unixTime)
        return str
    }
    
    func strDayFromUTC() -> String {
        let unixTime = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        let lang = Locale.preferredLanguages.first?.dropLast(3).description
        formatter.locale = Locale(identifier: lang ?? "en-En")
        formatter.dateFormat = "EE d"
        
        let strUnixTime = formatter.string(from: unixTime)
        let strNowTime = formatter.string(from: Date())
        
        if strUnixTime == strNowTime {
            return R.string.localizable.dayToday()
        } else {
            formatter.dateFormat = "EE"
            return formatter.string(from: unixTime)
        }
    }
    
    func strTimeFromNow() -> String {
        let unixTime = Date(timeIntervalSinceNow: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "HH:mm"
        let str = formatter.string(from: unixTime)
        return str
    }
    
    func strHourFromUTC(offset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let unixTime = Date(timeInterval: TimeInterval(offset), since: date)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "HH:mm"
        let str = formatter.string(from: unixTime)
        return str
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

// MARK: - UIColor

extension UIColor {
    
    convenience init(_ hex: String, alpha: CGFloat = 1.0) {
      var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if cString.hasPrefix("#") { cString.removeFirst() }
      
      if cString.count != 6 {
        self.init("ff0000") // return red color for wrong hex input
        return
      }
      
      var rgbValue: UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha)
    }
    
    static var random: UIColor { return UIColor(red:.random(in: 0...1),
                                green:.random(in: 0...1),
                                blue:.random(in: 0...1),
                                alpha:.random(in: 0.5...1))
//                                alpha:1)
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

