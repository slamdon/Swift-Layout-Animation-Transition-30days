//
//  LoadingViewController.swift
//  DrawingAnimation
//
//  Created by don chen on 2017/12/22.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var loadingView: UIView!
    
    lazy var shapeLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = customPath.cgPath
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 4.0
        layer.lineCap = kCALineCapRound
        return layer
    }()
    
    private var customPath: UIBezierPath {
        let bezierPath = UIBezierPath(ovalIn: CGRect(x: 35, y: 35, width: 75, height: 75))
        return bezierPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.layer.cornerRadius = 40
        loadingView.layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.byValue = 1.0
        animation.duration = 1.5
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float.infinity
        
        shapeLayer.add(animation, forKey: "drawChatIconAnimation")
        
    }
    
    @IBAction func dismissButtonTapHandler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
