//
//  HomeViewController.swift
//  BankCoins
//
//  Created by don chen on 2018/1/5.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var bankView:UIImageView!
    var fireButton:UIButton!
    
    let totalCoinCount           = 300
    var lastFinishedCoinNumber   = 0
    var animationDuration:Double = 1.5
    var coinNumbers              = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Bank Coins"
        
        setupView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        let screen = UIScreen.main.bounds
        
        bankView = UIImageView(image: UIImage(named:"icon_bank"))
        bankView.center = CGPoint(x: screen.midX, y: screen.height * 0.2)
        view.addSubview(bankView)
        
        fireButton = UIButton()
        fireButton.center = CGPoint(x: screen.midX, y: screen.maxY - 120)
        fireButton.bounds.size = CGSize(width: screen.width - 80, height: 44)
        fireButton.backgroundColor = UIColor(red: 11/255, green: 155/255, blue: 169/255, alpha: 1.0)
        fireButton.setTitle("Show me the money", for: .normal)
        fireButton.setTitleColor(UIColor.white, for: .normal)
        fireButton.addTarget(self, action: #selector(fireButtonClickHandler), for: .touchUpInside)
        view.addSubview(fireButton)
    }

    @objc fileprivate func fireButtonClickHandler() {
        startCoinanimation()
    }
    
    fileprivate func shakeBank() {
        let shake = CABasicAnimation(keyPath: "transform.rotation.z")
        shake.fromValue = -0.2
        shake.toValue = 0.2
        shake.duration = 0.1
        shake.autoreverses = true
        shake.repeatCount = 3
        
        bankView.layer.add(shake, forKey: "bankShakeAnimation")
    }
    
    fileprivate func startCoinanimation() {
        fireButton.isHidden = true
        lastFinishedCoinNumber = 0
        for i in 0...totalCoinCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.01, execute: {
                self.initCoinWith(number: i)
            })
        }
    }
    
    fileprivate func initCoinWith(number:Int) {
        let coinImageName = "icon_coin_\(number % 2 + 1)"
        let coinView = UIImageView(image: UIImage(named:coinImageName))
        let x = bankView.center.x
        let y = bankView.center.y - 20
        coinView.center = CGPoint(x: x , y: y)
        
        // plus 1 since view's tag default is 0 includingUIViewController.view's tag is 0
        coinView.tag = number + 1
        
        coinNumbers.append(coinView.tag)
        animate(coinView: coinView)
        view.addSubview(coinView)
    }
    
    fileprivate func animate(coinView:UIView) {
        let targetX = coinView.layer.position.x
        let targetY = coinView.layer.position.y
        
        let path = CGMutablePath()
        let fromX = CGFloat(arc4random() % 320)
        let fromY = CGFloat(arc4random() % UInt32(targetY))
        let height = UIScreen.main.bounds.height + coinView.frame.size.height
        
        let cpx = targetX + (fromX - targetX)/2
        let cpy = fromY / 2 - targetY
        
        // position where animation start
        path.move(to: CGPoint(x: fromX, y: height))
        path.addQuadCurve(to: CGPoint(x:targetX, y:targetY), control: CGPoint(x: cpx, y: cpy))
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.path = path
        
        // animate from big to small
        let from3DScale:CGFloat = 1 + CGFloat(arc4random() % 10) * 0.1
        let to3DScale:CGFloat = from3DScale * 0.5
        let scaleAniamtion = CAKeyframeAnimation(keyPath: "transform")
        scaleAniamtion.values = [
            CATransform3DMakeScale(from3DScale, to3DScale, from3DScale),
            CATransform3DMakeScale(to3DScale, to3DScale, to3DScale)
        ]
        scaleAniamtion.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        ]
        
        // combine animations
        let animationGroup = CAAnimationGroup()
        animationGroup.delegate = self
        animationGroup.duration = animationDuration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        animationGroup.animations = [positionAnimation, scaleAniamtion]
        coinView.layer.add(animationGroup, forKey: "coin animation group")
    }


}

extension HomeViewController:CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            lastFinishedCoinNumber += 1
            view.viewWithTag(coinNumbers.first!)?.removeFromSuperview()
            coinNumbers.removeFirst()
            
            if lastFinishedCoinNumber == totalCoinCount {
                shakeBank()
                fireButton.isHidden = false
            }
            
        }
    }
}
