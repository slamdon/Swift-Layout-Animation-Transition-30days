//
//  LoadingView.swift
//  LoadingAnimation-Switch
//
//  Created by don chen on 2018/1/16.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    fileprivate var dotGroup: [CAShapeLayer] = []
    fileprivate let cycleLayer: CAShapeLayer = CAShapeLayer()
    fileprivate let lineWidth = 8
    fileprivate let animationDuration = 1.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        for i in 0 ..< 3 {
            let dotLayer         = CAShapeLayer()
            dotLayer.bounds      = CGRect(x: 0, y: 0, width: lineWidth, height: lineWidth)
            dotLayer.path        = UIBezierPath(ovalIn: dotLayer.bounds).cgPath
            dotLayer.position    = CGPoint(x: bounds.width / CGFloat(2) * CGFloat(i), y: bounds.midY)
            dotLayer.fillColor   = UIColor.white.cgColor
            dotLayer.strokeColor = UIColor.white.cgColor
            layer.addSublayer(dotLayer)
            dotGroup.append(dotLayer)
        }
    }
    
    fileprivate func generateGroupAnimation(path: UIBezierPath, needRmoveOnCompletion: Bool, beginTime: CFTimeInterval) -> CAAnimationGroup {
        let pathToLeftAnimation = CAKeyframeAnimation(keyPath: "position")
        pathToLeftAnimation.path = path.cgPath
        pathToLeftAnimation.calculationMode = kCAAnimationPaced
        pathToLeftAnimation.duration = animationDuration / 2.0
        
        if needRmoveOnCompletion {
            pathToLeftAnimation.fillMode = kCAFillModeForwards
            pathToLeftAnimation.isRemovedOnCompletion = false
        }
        
        let delayGroupAnimation = CAAnimationGroup()
        delayGroupAnimation.animations = [pathToLeftAnimation]
        delayGroupAnimation.duration = animationDuration
        delayGroupAnimation.repeatCount = Float.infinity
        
        if beginTime != 0 {
            delayGroupAnimation.beginTime = CACurrentMediaTime() + beginTime
        }
        
        return delayGroupAnimation
    }
    
    func startLoading() {
        let dotLayer1: CAShapeLayer = dotGroup[0]
        let dotLayer2: CAShapeLayer = dotGroup[1]
        let dotLayer3: CAShapeLayer = dotGroup[2]
        
        let radius         = bounds.width / 4
        let arcCenterLeft  = CGPoint(x: radius, y: bounds.midY)
        let arcCenterRight = CGPoint(x: bounds.width - radius, y: bounds.midY)
        
        let pathToRight1 = UIBezierPath(arcCenter: arcCenterLeft, radius: radius, startAngle: CGFloat(Double.pi), endAngle: 0, clockwise: true)
        let pathToRight2 = UIBezierPath(arcCenter: arcCenterRight, radius: radius, startAngle: CGFloat(Double.pi), endAngle: 0, clockwise: true)
        pathToRight1.append(pathToRight2)
        
        // Animation - dot to right
        let pathToRightAnimation             = CAKeyframeAnimation(keyPath: "position")
        pathToRightAnimation.path            = pathToRight1.cgPath
        pathToRightAnimation.calculationMode = kCAAnimationPaced
        pathToRightAnimation.duration        = animationDuration
        pathToRightAnimation.repeatCount     = Float.infinity
        dotLayer1.add(pathToRightAnimation, forKey: "pathToRightAnimation")
        
        // Animation - dot to left
        let pathToLeft1   = UIBezierPath(arcCenter: arcCenterLeft, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        let dot2Animation = generateGroupAnimation(path: pathToLeft1, needRmoveOnCompletion: true, beginTime: 0)
        dotLayer2.add(dot2Animation, forKey: "dot2Animation")
        
        let pathToLeft2   = UIBezierPath(arcCenter: arcCenterRight, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        let dot3Animation = generateGroupAnimation(path: pathToLeft2, needRmoveOnCompletion: false, beginTime: animationDuration / 2.0)
        dotLayer3.add(dot3Animation, forKey: "dot3Animation")
    }
}
