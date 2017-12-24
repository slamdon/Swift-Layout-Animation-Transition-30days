//
//  UIView+Extension.swift
//  ExpandableTableView
//
//  Created by don chen on 2017/12/23.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Create Line view.
     
     - parameter frame:     The frame you give.
     - parameter lineColor: The line color.
     
     - returns: Line view.
     */
    class func CreateLine(_ frame : CGRect, lineColor : UIColor) -> UIView {
        
        let view                    = UIView(frame: frame)
        view.backgroundColor        = lineColor
        view.isUserInteractionEnabled = false
        
        return view
    }
    
    /// middlePoint
    var middlePoint : CGPoint {
        
        get { return CGPoint(x: bounds.width / 2, y: bounds.height / 2)}
    }
    
}


