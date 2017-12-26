//
//  SKScratchCardMaskView.swift
//  ScratchCard
//
//  Created by don chen on 2017/12/26.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class SKScratchCardMaskView:UIView {
    var strokeWidth: CGFloat = 20
    var strokeColor = UIColor.black
    
    fileprivate var paths: [CGMutablePath] = []
    fileprivate var currentPath: CGMutablePath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(strokeColor.cgColor)
        context?.setLineWidth(strokeWidth)
        context?.setLineCap(.round)
        
        for path in paths + [currentPath].flatMap({$0}) {
            context?.addPath(path)
            context?.strokePath()
        }
    }
    
    @objc func panGestureRecognizer(_ recognizer:UIPanGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        switch recognizer.state {
            case .began:
                beginPath(at: location)
            
            case .changed:
                addLine(to: location)
            
            default:
                closePath()
        }
    }
    
    public func clearCanvas() {
        paths.removeAll()
        setNeedsDisplay()
    }
    
    public func beginPath(at point: CGPoint) {
        currentPath = CGMutablePath()
        currentPath?.move(to: point)
        setNeedsDisplay()
    }
    
    public func addLine(to point: CGPoint) {
        currentPath?.addLine(to: point)
        setNeedsDisplay()
    }
    
    public func closePath() {
        if let currentPath = currentPath {
            paths.append(currentPath)
        }
        currentPath = nil
        setNeedsDisplay()
    }
    
}

