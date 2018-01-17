//
//  LoadingView.swift
//  LoadingAnimation-Walk
//
//  Created by don chen on 2018/1/17.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    fileprivate var dotGroup: [CAShapeLayer] = []
    fileprivate let dotCount = 5
    fileprivate let lineWidth = 8
    fileprivate let animationDuration = 0.8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {

        for i in 0 ..< dotCount {
            let dotLayer = CAShapeLayer()
            dotLayer.bounds = CGRect(x: 0, y: 0, width: lineWidth, height: lineWidth)
            dotLayer.path = UIBezierPath(ovalIn: dotLayer.bounds).cgPath
            dotLayer.position = CGPoint(x: CGFloat(i) * bounds.width / CGFloat(dotCount - 1), y: bounds.height / 2.0)
            dotLayer.fillColor = UIColor.white.cgColor
            dotLayer.strokeColor = UIColor.white.cgColor
            
            layer.addSublayer(dotLayer)
            dotGroup.append(dotLayer)
        }
    }
    
    func startLoading() {
        // Animation - move dot1 to right
        let dotLayer1 = dotGroup[0]
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.path = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0), radius: bounds.width / 2.0, startAngle: CGFloat(Double.pi), endAngle: 0, clockwise: true).cgPath
        pathAnimation.calculationMode = kCAAnimationPaced
        pathAnimation.duration        = animationDuration
        pathAnimation.repeatCount     = Float.infinity
        dotLayer1.add(pathAnimation, forKey: "pathAnimation")
        
        // Animation - move other dots to left
        for i in 1 ..< dotCount {
            let dotLayer = dotGroup[i]
            let positionAnimation = CABasicAnimation(keyPath: "position.x")
            positionAnimation.toValue     = dotLayer.position.x - bounds.width / CGFloat(dotCount - 1)
            positionAnimation.duration    = animationDuration
            positionAnimation.repeatCount = Float.infinity
            dotLayer.add(positionAnimation, forKey: "positionAnimation")
        }
    }
}
