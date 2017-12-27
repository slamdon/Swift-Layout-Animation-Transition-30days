//
//  HomeViewController.swift
//  FlipCard
//
//  Created by don chen on 2017/12/27.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    fileprivate var cardLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flip Card"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    private func setupView() {
        let screen                       = UIScreen.main.bounds
        let cardImage                    = UIImage(named: "img-card")!
        let cardWidth                    = screen.width * 0.5
        let cardHeight                   = cardImage.size.height * (cardWidth / cardImage.size.width)
        cardLayer                        = CALayer()
        cardLayer.contents               = cardImage.cgImage
        cardLayer.anchorPoint            = CGPoint(x: 1.0, y: 0.5)
        
        cardLayer.frame                  = CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight)
        cardLayer.position               = CGPoint(x: view.frame.midX, y: view.frame.midY / 2)
        view.layer.addSublayer(cardLayer)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func panHandler(_ sender: UIPanGestureRecognizer) {
        let screen = UIScreen.main.bounds
        let point  = sender.location(in: view)
        
        // init perspective transform
        var perspectiveTransform = CATransform3DIdentity
        perspectiveTransform.m34 = -1.0 / 500.0
        
        // roate - 將平面滑動的距離轉換成弧度
        let rate:CGFloat     = 180 / screen.width
        let angle            = point.x * rate * CGFloat(Double.pi) / 180.0
        perspectiveTransform = CATransform3DRotate(perspectiveTransform, angle, 0, 1, 0)
        CATransaction.setDisableActions(true)
        cardLayer.transform = perspectiveTransform
        
        // change image when roate over half
        cardLayer.contents = UIImage(named: point.x >= screen.width / 2.0 ? "img-tree" : "img-card")?.cgImage
        
        // when pan ended
        if sender.state == .ended {
            // init perspectiveTransform
            perspectiveTransform = CATransform3DIdentity
            perspectiveTransform.m34 = -1.0 / 500.0

            // rotate
            let x:CGFloat = point.x >= (screen.width / 2) ? 180 : 0
            let angle     = x * CGFloat(Double.pi) / 180.0
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, angle , 0, 1, 0)

            CATransaction.setDisableActions(false)
            cardLayer.transform = perspectiveTransform
        }

    }
    

}
