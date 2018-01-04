//
//  UIColor+Extension.swift
//  HotelCardLayout
//
//  Created by don chen on 2018/1/4.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

extension UIColor{
    func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        
        return hexInt
    }
}
