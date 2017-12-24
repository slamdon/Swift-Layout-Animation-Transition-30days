//
//  UIColor+Extension.swift
//  ExpandableTableView
//
//  Created by don chen on 2017/12/23.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

extension UIColor {
    
    /**
     Creates and returns a color object that has the same color space and component values as the receiver, but has the specified alpha component.
     
     - parameter alpha: The opacity value of the new UIColor object.
     
     - returns: The new UIColor object.
     */
    func alpha(_ alpha : CGFloat) -> UIColor {
        
        return self.withAlphaComponent(alpha)
    }
}
