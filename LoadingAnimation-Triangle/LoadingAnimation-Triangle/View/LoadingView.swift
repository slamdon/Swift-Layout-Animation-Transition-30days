//
//  LoadingView.swift
//  LoadingAnimation-Triangle
//
//  Created by don chen on 2018/1/14.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    fileprivate let dotCount = 3
    fileprivate var dotGroup:[CAShapeLayer] = []
    fileprivate var animationDuration = 0.8
    fileprivate var lineWidth:CGFloat = 8.0
    
    fileprivate var width: CGFloat {
        return frame.size.width / 2
    }
    
    fileprivate var leftPoint:CGPoint {
        return CGPoint(x: 0, y: width)
    }
    
    fileprivate var rightPoint:CGPoint {
        return CGPoint(x: width, y: width)
    }
    
    fileprivate var topPoint: CGPoint {
        return CGPoint(x: width/2, y: 0)
    }
    
    fileprivate var points:[CGPoint]     = []
    fileprivate var nextPoints:[CGPoint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        points     = [rightPoint, leftPoint, topPoint]
        nextPoints = [leftPoint, topPoint, rightPoint]
        
        for i in 0 ..< dotCount {
            let dotLayer         = CAShapeLayer()
            dotLayer.bounds      = CGRect(x: 0, y: 0, width: lineWidth, height: lineWidth)
            dotLayer.path        = UIBezierPath(ovalIn: dotLayer.bounds).cgPath
            dotLayer.fillColor   = UIColor.white.cgColor
            dotLayer.strokeColor = UIColor.white.cgColor
            dotLayer.position    = points[i]
            layer.addSublayer(dotLayer)
            dotGroup.append(dotLayer)
        }
    }

    func startLoading() {
        
        for i in 0 ..< dotCount {
            let dotLayer = dotGroup[i]
            let positionAnimation = CABasicAnimation(keyPath: "position")
            positionAnimation.toValue = nextPoints[i]
            positionAnimation.duration = animationDuration
            positionAnimation.repeatCount = Float.infinity
            dotLayer.add(positionAnimation, forKey: "positionAnimation")
        }
    }
}
