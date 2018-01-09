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
    var startBackgroundColor: UIColor?
    
    var isReverse = false
    var transitionDuration:TimeInterval = 0.5
    
    private override init() { super.init() }
    convenience init(animatedView: UIView) {
        self.init()
        self.animatedView = animatedView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // get frame and backgroundColor
        var startFrame = CGRect.zero
        if animatedView != nil {
            startFrame = animatedView!.frame
            startBackgroundColor = animatedView!.backgroundColor
        }
        
        // init animated view for transition
        let animatedViewForTransition = UIView(frame: startFrame)
        animatedViewForTransition.clipsToBounds = true
        animatedViewForTransition.layer.cornerRadius = animatedViewForTransition.frame.height / 2.0
        animatedViewForTransition.backgroundColor = self.startBackgroundColor
        
        // add animated view on transitionContext's containerView
        transitionContext.containerView.addSubview(animatedViewForTransition)
        
        // set presentedController
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
            },completion: nil)
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext) * 0.4,
                           delay: self.transitionDuration(using: transitionContext) * 0.6,
                           animations: {
                            presentedController.view.layer.opacity = 1
            },completion: { (_) in
                animatedViewForTransition.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            
        } else {
            animatedViewForTransition.transform = finalTransform
            animatedViewForTransition.center = transitionContext.containerView.center
            animatedViewForTransition.backgroundColor = presentedController.view.backgroundColor
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext) * 0.7, animations: {
                presentedController.view.layer.opacity = 0
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + self.transitionDuration(using: transitionContext) * 0.3) {
                UIView.transition(with: animatedViewForTransition,
                                  duration: self.transitionDuration(using: transitionContext) * 0.6,
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
