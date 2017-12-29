//
//  HomeViewController.swift
//  MerryChristmas
//
//  Created by don chen on 2017/12/29.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Merry Christmas"
        
        setupView()
    }
    
    private func setupView() {
        // init EmitterCell with image
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "snow.png")?.cgImage
        
        emitterCell.birthRate = 180
        
        emitterCell.lifetime = 5.5
        emitterCell.lifetimeRange = 1.0
        
        emitterCell.yAcceleration = 30.0
        emitterCell.xAcceleration = 10.0
        
        emitterCell.velocity = 30.0
        emitterCell.velocityRange = 200.0
        
        emitterCell.emissionLongitude = .pi * -0.5
        emitterCell.emissionRange = .pi * 0.5
        
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8
        emitterCell.scaleSpeed = -0.15

        emitterCell.alphaRange = 0.75
        emitterCell.alphaSpeed = -0.15
        
        // init emitter
        let rect = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 40.0)
        let emitter = CAEmitterLayer()
        emitter.emitterCells = [emitterCell]
        emitter.frame = rect
        
        // appear way
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
        emitter.emitterSize = rect.size
        view.layer.addSublayer(emitter)
        
    }


}
