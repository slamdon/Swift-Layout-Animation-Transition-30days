//
//  HomeViewController.swift
//  DrawingAnimation
//
//  Created by don chen on 2017/12/22.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var customCanvas: UIView!
    
    lazy var shapeLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = customPath.cgPath
        layer.strokeColor = UIColor.yellow.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 4.0
        layer.lineCap = kCALineCapRound
        return layer
    }()
    
    private var customPath: UIBezierPath {
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 166.1, y: 48.28))
        bezier2Path.addCurve(to: CGPoint(x: 166.1, y: 131.72), controlPoint1: CGPoint(x: 199.3, y: 71.32), controlPoint2: CGPoint(x: 199.3, y: 108.68))
        bezier2Path.addCurve(to: CGPoint(x: 89.68, y: 147.91), controlPoint1: CGPoint(x: 145.34, y: 146.13), controlPoint2: CGPoint(x: 116.5, y: 151.53))
        bezier2Path.addCurve(to: CGPoint(x: 43.5, y: 169.5), controlPoint1: CGPoint(x: 71.56, y: 159.66), controlPoint2: CGPoint(x: 43.5, y: 169.5))
        bezier2Path.addCurve(to: CGPoint(x: 58.33, y: 138.86), controlPoint1: CGPoint(x: 43.5, y: 169.5), controlPoint2: CGPoint(x: 53.16, y: 153.11))
        bezier2Path.addCurve(to: CGPoint(x: 45.9, y: 131.72), controlPoint1: CGPoint(x: 53.95, y: 136.8), controlPoint2: CGPoint(x: 49.78, y: 134.42))
        bezier2Path.addCurve(to: CGPoint(x: 45.9, y: 48.28), controlPoint1: CGPoint(x: 12.7, y: 108.68), controlPoint2: CGPoint(x: 12.7, y: 71.32))
        bezier2Path.addCurve(to: CGPoint(x: 166.1, y: 48.28), controlPoint1: CGPoint(x: 79.09, y: 25.24), controlPoint2: CGPoint(x: 132.91, y: 25.24))
        bezier2Path.close()
        bezier2Path.lineWidth = 9
        bezier2Path.stroke()
        
        return bezier2Path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Drawing Animation"
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupView() {
        customCanvas.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func sliderValueChangeHandler(_ slider: UISlider) {
        shapeLayer.strokeEnd = CGFloat(slider.value)
    }
    
    @IBAction func showLoadingViewButtonTapHandler(_ sender: Any) {
        let VC = LoadingViewController()
        VC.modalPresentationStyle = .overFullScreen
        VC.modalTransitionStyle = .crossDissolve
        present(VC, animated: true, completion: nil)
    }
    


}
