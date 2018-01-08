//
//  SKDiffusionTransition.swift
//  ColorDiffusionTransition
//
//  Created by don chen on 2018/1/8.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class SKDiffussionTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var animatedView: UIView?
    var startFrame = CGRect.zero
    var startBackgroundColor: UIColor?
    
    var isReverse = false
    var transitionDuration:TimeInterval = 0.5
    
    convenience init(animatedView: UIView) {
        self.init()
        self.animatedView = animatedView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let animatedView = animatedView, let superview = animatedView.superview {
            // Get the frame rect in the screen coordinates
            self.startFrame = superview.convert(animatedView.frame, to: nil)
            startBackgroundColor = animatedView.backgroundColor
        }
        
        // Use if the transitionContext.containerView is not fullScreen
        let startFrame = transitionContext.containerView.superview?.convert(self.startFrame, to: transitionContext.containerView) ?? self.startFrame
        
        let animatedViewForTransition = UIView(frame: startFrame)
        transitionContext.containerView.addSubview(animatedViewForTransition)
        
        animatedViewForTransition.clipsToBounds = true
        animatedViewForTransition.layer.cornerRadius = animatedViewForTransition.frame.height / 2.0
        animatedViewForTransition.backgroundColor = self.startBackgroundColor
        
        let presentedController: UIViewController
        if !isReverse {
            presentedController = transitionContext.viewController(forKey: .to)!
            presentedController.view.layer.opacity = 0
        } else {
            presentedController = transitionContext.viewController(forKey: .from)!
        }
        
        presentedController.view.frame = transitionContext.containerView.bounds
        transitionContext.containerView.addSubview(presentedController.view)
        
        let size = max(transitionContext.containerView.frame.height, transitionContext.containerView.frame.width) * 1.2
        let scaleFactor = size / animatedViewForTransition.frame.width
        let finalTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        
        
        if !self.isReverse {
            UIView.transition(with: animatedViewForTransition,
                              duration: self.transitionDuration(using: transitionContext) * 0.7,
                              options: [],
                              animations: {
                                animatedViewForTransition.transform = finalTransform
                                animatedViewForTransition.center = transitionContext.containerView.center
                                animatedViewForTransition.backgroundColor = presentedController.view.backgroundColor
            },
                              completion: { (_) in
            })
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext) * 0.42,
                           delay: self.transitionDuration(using: transitionContext) * 0.58,
                           animations: {
                            presentedController.view.layer.opacity = 1
            },
                           completion: { (_) in
                            animatedViewForTransition.removeFromSuperview()
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        else {
            animatedViewForTransition.transform = finalTransform
            animatedViewForTransition.center = transitionContext.containerView.center
            animatedViewForTransition.backgroundColor = presentedController.view.backgroundColor
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext) * 0.7, animations: {
                presentedController.view.layer.opacity = 0
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + self.transitionDuration(using: transitionContext) * 0.32) {
                UIView.transition(with: animatedViewForTransition,
                                  duration: self.transitionDuration(using: transitionContext) * 0.58,
                                  options: [],
                                  animations: {
                                    animatedViewForTransition.transform = CGAffineTransform.identity
                                    animatedViewForTransition.backgroundColor = self.startBackgroundColor
                                    animatedViewForTransition.frame = startFrame
                },
                                  completion: { (_) in
                                    animatedViewForTransition.removeFromSuperview()
                                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
    }
    
}

extension SKDiffussionTransition: UIViewControllerTransitioningDelegate {
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isReverse = false
        return self
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isReverse = true
        return self
    }
}
