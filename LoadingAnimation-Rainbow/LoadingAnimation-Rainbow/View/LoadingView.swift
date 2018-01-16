//
//  LoadingView.swift
//  LoadingAnimation-Rainbow
//
//  Created by don chen on 2018/1/14.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    fileprivate let dotCount = 3
    fileprivate var dotGroup:[CAShapeLayer] = []
    fileprivate var shadowGroup:[CALayer] = []
    fileprivate var animationDuration = 3.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {

        for _ in 0 ..< dotCount {
            let dotLayer = CAShapeLayer()
            dotLayer.lineCap = "round"
            dotLayer.lineJoin = "round"
            dotLayer.lineWidth = 6
            dotLayer.fillColor = UIColor.clear.cgColor
            dotLayer.strokeColor = UIColor.white.cgColor
            dotLayer.strokeEnd = 0.000001
            layer.addSublayer(dotLayer)
            dotGroup.append(dotLayer)
            
            dotLayer.shadowColor = UIColor.black.cgColor
            dotLayer.shadowOffset = CGSize(width: 10, height: 10)
            dotLayer.shadowOpacity = 0.2
            dotLayer.shadowRadius = 10
        }
        
        for i in 0 ..< dotCount {
            let dotLayer = dotGroup[i]
            let dotWidth = bounds.width * CGFloat((dotCount - i)) * 0.6
            dotLayer.bounds = CGRect(x: 0, y: 0, width: dotWidth, height: dotWidth)
            dotLayer.position = CGPoint(x: bounds.width * 1.1, y: bounds.height / 2.0)
            dotLayer.path = UIBezierPath(arcCenter: CGPoint(x: dotWidth / 2.0 - bounds.width * 0.3, y: dotWidth / 2.0), radius: dotWidth * 0.25, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi * 2), clockwise: true).cgPath
        }
    }
    
    func startLoading() {
        for i in 0 ..< dotCount {
            let dotLayer = dotGroup[i]
            
            let transformAnimation = CABasicAnimation(keyPath: "position.x")
            transformAnimation.fromValue = bounds.width * 1.1
            transformAnimation.toValue = bounds.width * 0.5
            transformAnimation.duration = animationDuration
            transformAnimation.fillMode = kCAFillModeForwards
            transformAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            transformAnimation.isRemovedOnCompletion = false
            
            let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeEndAnimation.fromValue = 0
            strokeEndAnimation.toValue = 1
            
            let strokeStartAniamtion = CABasicAnimation(keyPath: "strokeStart")
            strokeStartAniamtion.fromValue = -1
            strokeStartAniamtion.toValue = 1
            
            let strokeAnimationGroup = CAAnimationGroup()
            strokeAnimationGroup.duration = (animationDuration - TimeInterval(3 - i) * animationDuration * 0.1) * 0.8
            strokeAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            strokeAnimationGroup.fillMode = kCAFillModeForwards
            strokeAnimationGroup.isRemovedOnCompletion = false
            strokeAnimationGroup.animations = [strokeStartAniamtion, strokeEndAnimation]
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = animationDuration
            animationGroup.repeatCount = Float.infinity
            animationGroup.animations = [transformAnimation, strokeAnimationGroup]
            dotLayer.add(animationGroup, forKey: "animationGroup")
        }
    }
}
