//
//  SKExpandTransition.swift
//  ExpandTransition
//
//  Created by don chen on 2018/1/9.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class SKExpandTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var operation: UINavigationControllerOperation?
    var duration:TimeInterval = 0
    var selectedFrame = CGRect.zero
    
    var imageViewTop:UIImageView?
    var imageViewBottom:UIImageView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let sourceViewController = transitionContext.viewController(forKey: .from)!
        let sourceView = sourceViewController.view
        
        let destinationViewController = transitionContext.viewController(forKey: .to)!
        let destinationView = destinationViewController.view
        
        let container = transitionContext.containerView
        
        let finalFrame = transitionContext.finalFrame(for: destinationViewController)
        
        // must set final frame, because it could be (0.0, 64.0, 768.0, 960.0)
        // and the destinationView frame could be (0 0; 768 1024)
        destinationView?.frame = finalFrame
        
        var snapShot = UIImage()
        let bounds = CGRect(x: 0, y: 0, width: (sourceView?.bounds.size.width)!, height: (sourceView?.bounds.size.height)!)
        
        if operation == .push {
            // 抓一張SourceView的圖（HomeViewController）
            UIGraphicsBeginImageContextWithOptions((sourceView?.bounds.size)!, true, 1)
            sourceView?.drawHierarchy(in: bounds, afterScreenUpdates: false)
            snapShot = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            // SnapShot的圖
            let tempImageRef = snapShot.cgImage!
            
            // selectedFrame是使用者所點選cell的屬性frame
            let topHeight = selectedFrame.origin.y
            
            let imageViewTopFrame = CGRect(x: 0, y: 0, width: bounds.width, height: topHeight)
            let imageViewBottomFrame = CGRect(x: 0,
                                              y: topHeight,
                                              width: bounds.width,
                                              height: bounds.height - selectedFrame.origin.y)
            
            let topImageRef = tempImageRef.cropping(to: imageViewTopFrame)
            let bottomImageRef = tempImageRef.cropping(to: imageViewBottomFrame)
            
            // 上半部的圖片
            if topImageRef != nil {
                imageViewTop = UIImageView(image: UIImage(cgImage: topImageRef!, scale: snapShot.scale, orientation: UIImageOrientation.up))
                imageViewTop?.frame = imageViewTopFrame
            }
            
            if (bottomImageRef != nil) {
                // 下半部的圖片
                imageViewBottom = UIImageView(image: UIImage(cgImage: bottomImageRef!, scale: snapShot.scale, orientation: UIImageOrientation.up))
                imageViewBottom!.frame = imageViewBottomFrame
            }
            
        }
        
        destinationView?.alpha = 0
        sourceView?.alpha = 0
        
        let backgroundView = UIView(frame: bounds)
        backgroundView.backgroundColor = UIColor.black
        
        // animation
        if self.operation == .push {
            container.addSubview(backgroundView)
            container.addSubview(destinationView!)
            container.addSubview(self.imageViewTop!)
            container.addSubview(self.imageViewBottom!)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
                self.imageViewTop!.frame = CGRect(x: 0,
                                                  y: -self.imageViewTop!.frame.height,
                                                  width: self.imageViewTop!.frame.width,
                                                  height: self.imageViewTop!.frame.height)
                
                self.imageViewBottom!.frame = CGRect(x: 0,
                                                     y: bounds.height,
                                                     width: self.imageViewBottom!.frame.width,
                                                     height: self.imageViewBottom!.frame.height)
                
                destinationView?.alpha = 1
                
            }, completion: { (finish) -> Void in
                self.imageViewTop?.removeFromSuperview()
                self.imageViewBottom?.removeFromSuperview()
                
                transitionContext.completeTransition(true)
            })
            
        } else {
            sourceView?.alpha = 1
            
            container.addSubview(backgroundView)
            container.addSubview(sourceView!)
            container.addSubview(destinationView!)
            container.addSubview(imageViewTop!)
            container.addSubview(imageViewBottom!)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
                self.imageViewTop!.frame = CGRect(x: 0,
                                                  y: 0,
                                                  width: self.imageViewTop!.frame.width,
                                                  height: self.imageViewTop!.frame.height)
                
                self.imageViewBottom!.frame = CGRect(x: 0,
                                                     y: bounds.height - self.imageViewBottom!.frame.height,
                                                     width: self.imageViewBottom!.frame.width,
                                                     height: self.imageViewBottom!.frame.height)
                
                
                sourceView?.alpha = 0
                
            }, completion: { (finish) -> Void in
                self.imageViewTop?.removeFromSuperview()
                self.imageViewBottom?.removeFromSuperview()
                
                destinationView?.alpha = 1
                transitionContext.completeTransition(true)
            })
            
        }
        
        
    }
}


extension SKExpandTransition: UIViewControllerTransitioningDelegate {
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self
    }
}
