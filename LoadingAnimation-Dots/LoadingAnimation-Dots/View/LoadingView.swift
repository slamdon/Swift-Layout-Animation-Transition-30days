//
//  LoadingView.swift
//  LoadingAnimation-Dots
//
//  Created by don chen on 2018/1/14.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    fileprivate let dotLayer: CAShapeLayer = CAShapeLayer()
    fileprivate let dotReplicatorLayer: CAReplicatorLayer = CAReplicatorLayer()
    fileprivate let dotCount = 3
    fileprivate let animationDuration = 1.0
    fileprivate let lineWidth:CGFloat = 4.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {

        dotLayer.frame       = CGRect(x: lineWidth / 2.0, y: (bounds.height - lineWidth) / 2.0, width: lineWidth, height: lineWidth)
        dotLayer.path        = UIBezierPath(ovalIn: dotLayer.bounds).cgPath
        dotLayer.fillColor   = UIColor.white.cgColor
        dotLayer.strokeColor = UIColor.white.cgColor
        dotLayer.lineCap     = kCALineCapRound
        dotLayer.lineJoin    = kCALineJoinRound
        dotLayer.lineWidth   = lineWidth
        
        dotReplicatorLayer.addSublayer(dotLayer)
        dotReplicatorLayer.instanceCount     = dotCount
        dotReplicatorLayer.instanceDelay     = animationDuration / Double(dotCount)
        dotReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(bounds.width / CGFloat(dotCount), 0, 0)
        layer.addSublayer(dotReplicatorLayer)
    }
    
    func startLoading() {
        let downY = bounds.midY + 10.0
        
        let positionAnimation         = CAKeyframeAnimation(keyPath: "position.y")
        positionAnimation.duration    = animationDuration
        positionAnimation.beginTime   = CACurrentMediaTime() + 0.5
        positionAnimation.repeatCount = Float.infinity
        positionAnimation.values      = [bounds.midY, downY, bounds.midY, bounds.midY]
        positionAnimation.keyTimes    = [0.0, 0.33, 0.66, 1.0]
        dotLayer.add(positionAnimation, forKey: "positionAnimation")
    }
}
