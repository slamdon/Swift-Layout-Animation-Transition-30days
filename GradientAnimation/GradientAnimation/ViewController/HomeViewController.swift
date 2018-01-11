//
//  HomeViewController.swift
//  GradientAnimation
//
//  Created by don chen on 2018/1/11.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var gradientLayer:CAGradientLayer!
    var gradientSet = [[CGColor]]()
    var currentGradient:Int = 0
    
    let colorOne = UIColor(red: 247/255, green: 0, blue: 68.255, alpha: 1.0).cgColor
    let colorTwo = UIColor(red: 246/255, green: 214/255, blue: 0, alpha: 1.0).cgColor
    let colorThree = UIColor(red: 17/205, green: 205/255, blue: 134/255, alpha: 1.0).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gradient Animation"
        
        setupView()
    }
    
    fileprivate func setupView() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 42/255, green: 147/255, blue: 212/255, alpha: 1.0).cgColor,
            UIColor(red: 240/255, green: 105/255, blue: 102/255, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.addSublayer(gradientLayer)
        
        gradientSet = [
            [colorOne, colorTwo],
            [colorTwo, colorThree],
            [colorThree, colorOne]
        ]
        
        let button = UIButton()
        button.setTitle("GO", for: .normal)
        button.layer.cornerRadius = 22
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.frame.size = CGSize(width: 120, height: 44)
        button.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        button.backgroundColor = UIColor(red: 240/255, green: 105/255, blue: 102/255, alpha: 1.0)
        button.addTarget(self, action: #selector(buttonClickHandler), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    @objc fileprivate func buttonClickHandler() {
        animateGradient()
    }
    
    func animateGradient() {
        if(currentGradient >= gradientSet.count){ currentGradient = 0 }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 1.5
        gradientChangeAnimation.delegate = self
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = kCAFillModeForwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
    }


}

extension HomeViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradientLayer.colors = gradientSet[currentGradient]
            currentGradient += 1
        }
    }
}
