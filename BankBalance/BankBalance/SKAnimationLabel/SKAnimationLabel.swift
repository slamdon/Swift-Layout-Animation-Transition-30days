//
//  SKAnimationLabel.swift
//  BankBalance
//
//  Created by don chen on 2017/12/20.
//  Copyright © 2017年 Don Chen. All rights reserved.
//
import UIKit

class SKAnimationLabel: UILabel {
    
    fileprivate var animationDuration = 2.0
    
    fileprivate var startingValue: Float = 0
    fileprivate var destinationValue: Float = 0
    fileprivate var progress: TimeInterval = 0
    
    fileprivate var lastUpdateTime: TimeInterval = 0
    fileprivate var totalTime: TimeInterval = 0
    
    fileprivate var timer: CADisplayLink?
    
    fileprivate var currentValue: Float {
        if progress >= totalTime { return destinationValue }
        return startingValue + Float(progress / totalTime) * (destinationValue - startingValue)
    }
    
    fileprivate func addDisplayLink() {
        timer = CADisplayLink(target: self, selector: #selector(self.updateValue(timer:)))
        timer?.add(to: .main, forMode: .defaultRunLoopMode)
        timer?.add(to: .main, forMode: .UITrackingRunLoopMode)
    }
    
    @objc fileprivate func updateValue(timer: Timer) {
        let now: TimeInterval = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdateTime
        lastUpdateTime = now
        
        if progress >= totalTime {
            self.timer?.invalidate()
            self.timer = nil
            progress = totalTime
        }
        
        setTextValue(value: currentValue)
    }
    
    // update UILabel.text
    fileprivate func setTextValue(value: Float) {
        DispatchQueue.main.async { [unowned self] in
            self.text = String(format: "$ %.1f", value)
        }
    }
}

// MARK: Counting Method
extension SKAnimationLabel {
    func count(from: Float, to: Float, duration: TimeInterval? = nil) {
        startingValue = from
        destinationValue = to
        
        timer?.invalidate()
        timer = nil
        
        if (duration == 0.0) {
            // No animation
            setTextValue(value: to)
            return
        }
        
        progress = 0.0
        totalTime = duration ?? animationDuration
        lastUpdateTime = Date.timeIntervalSinceReferenceDate
        
        addDisplayLink()
    }
    
    func countFromCurrent(to: Float, duration: TimeInterval? = nil) {
        count(from: currentValue, to: to, duration: duration ?? nil)
    }
}
