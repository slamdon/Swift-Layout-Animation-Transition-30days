//
//  SKScratchCardView.swift
//  ScratchCard
//
//  Created by don chen on 2017/12/26.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class SKScratchCardView:UIView {
    private var coverView = UIView()
    private var contentView = UIView()
    private var contentMaskView = SKScratchCardMaskView()
    
    var strokeWidth:CGFloat = 0 {
        didSet {
            self.contentMaskView.strokeWidth = self.strokeWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupWith(coverView:UIView, contentView:UIView) {
        // cover view
        self.coverView = coverView
        
        // content view
        self.contentView = contentView
        
        // maskView
        self.contentMaskView.frame = coverView.frame
        self.contentMaskView.backgroundColor = UIColor.clear
        self.contentMaskView.strokeWidth = 40.0

        // addSubviews
        addSubviewFullscreen(self.coverView)
        addSubviewFullscreen(self.contentView)
        addSubviewFullscreen(self.contentMaskView)
        
        // set mask
        self.contentView.mask = self.contentMaskView

        // add gesture
        setupPanGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviewFullscreen(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[subview]-(0)-|",
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: ["subview": subview]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[subview]-(0)-|",
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: ["subview": subview]))
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: contentMaskView, action: #selector(contentMaskView.panGestureRecognizer))
        self.addGestureRecognizer(panGesture)
    }
    
    public func clearCanvas() {
        contentMaskView.clearCanvas()
    }
    
}
