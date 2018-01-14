//
//  LoadingView.swift
//  LoadingAnimation-Zhihu
//
//  Created by don chen on 2018/1/14.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    fileprivate let cycleLayer: CAShapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {

        cycleLayer.lineWidth = 4
        cycleLayer.fillColor = UIColor.clear.cgColor
        cycleLayer.strokeColor = UIColor.white.cgColor
        
        cycleLayer.lineCap = kCALineCapRound
        cycleLayer.lineJoin = kCALineJoinRound
        
        cycleLayer.frame = bounds
        cycleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        layer.addSublayer(cycleLayer)
    }
    
    func startLoading() {
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -1
        strokeStartAnimation.toValue = 1.0
        strokeStartAnimation.repeatCount = Float.infinity
        cycleLayer.add(strokeStartAnimation, forKey: "strokeStartAnimation")

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1.0
        strokeEndAnimation.repeatCount = Float.infinity
        cycleLayer.add(strokeEndAnimation, forKey: "strokeStartAnimation")

        let animationGroup = CAAnimationGroup()
        animationGroup.repeatCount = Float.infinity
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        animationGroup.duration = 3.0
        cycleLayer.add(animationGroup, forKey: "animationGroup")

        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = Double.pi * 2
        rotateAnimation.repeatCount = Float.infinity
        rotateAnimation.duration = 3.0 * 4
        cycleLayer.add(rotateAnimation, forKey: "rotateAnimation")
    }
}
