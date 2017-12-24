//
//  RotateView.swift
//  ExpandableTableView
//
//  Created by don chen on 2017/12/23.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class ArrowView: UIView {
    
    // MARK: Properties.
    
    var rotateDuration : TimeInterval = 0.25
    
    // MARK: Animation method.
    
    func changeToUpAnimated(_ animated : Bool) {
        
        UIView.animate(withDuration: (animated == true ? self.rotateDuration : 0.0), animations: {
            
            self.transform = self.defaultTransform
        })
    }
    
    func changeToRightAnimated(_ animated : Bool) {
        
        UIView.animate(withDuration: (animated == true ? self.rotateDuration : 0.0), animations: {
            
            self.transform = self.defaultTransform.rotated(by: CGFloat(Double.pi / 2))
        })
    }
    
    // MARK: Private value & func & system method.
    
    fileprivate var defaultTransform : CGAffineTransform!
    
    override init(frame: CGRect) {
        
        super.init(frame : frame)
        defaultTransform = self.transform
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
