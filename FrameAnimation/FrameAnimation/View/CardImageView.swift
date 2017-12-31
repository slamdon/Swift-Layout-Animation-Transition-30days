//
//  CardImageView.swift
//  FrameAnimation
//
//  Created by don chen on 2017/12/30.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {

    private var cardBackView: UIImageView!
    private var  cardBorderView: UIImageView!
    private var cardBackAuraView: UIImageView!
    
    private var auraBlueImages  = [UIImage]()
    private var auraRedImages   = [UIImage]()
    private var auraGrayImages  = [UIImage]()
    private var auraGreenImages = [UIImage]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAuraImages()
        setupView()
    }
    
    fileprivate func setupView() {
        isUserInteractionEnabled = true
        
        // background image
        image = UIImage(named: "img-card-bg-blue")!
        
        addAuraView()
        addMonsterView()
        addCardBackView()
        startBorderAnimation()
    }
    
    fileprivate func setupAuraImages() {
        for i in 1...30 {
            auraBlueImages.append(UIImage(named: "img-aura-blue-\(i)")!)
            auraGreenImages.append(UIImage(named: "img-aura-green-\(i)")!)
            auraGrayImages.append(UIImage(named: "img-aura-gray-\(i)")!)
            auraRedImages.append(UIImage(named: "img-aura-red-\(i)")!)
        }
    }
    
    fileprivate func addCardBackView() {
        cardBackView             = UIImageView()
        cardBackView.frame.size  = frame.size
        cardBackView.image       = UIImage(named: "img-card-back")!
        cardBackView.contentMode = .scaleAspectFill
        addSubview(cardBackView)
        
        cardBorderView = UIImageView()
        cardBorderView.frame.size  = CGSize(width: cardBackView.frame.size.width * 1.1,
                                            height: cardBackView.frame.size.height * 1.1)
        cardBorderView.center      = cardBackView.center
        cardBorderView.image       = UIImage(named: "img-card-border-white")!
        cardBorderView.contentMode = .scaleAspectFit
        addSubview(cardBorderView)
        
    }
    
    
    fileprivate func addAuraView() {
        cardBackAuraView                      = UIImageView()
        cardBackAuraView.animationImages      = auraGrayImages
        cardBackAuraView.frame.size           = CGSize(width: frame.size.width * 2.5, height: frame.size.height * 2.5)
        cardBackAuraView.center               = center
        cardBackAuraView.animationRepeatCount = 0
        cardBackAuraView.animationDuration    = 2.0
        cardBackAuraView.startAnimating()
        addSubview(cardBackAuraView)
        
        
        let auraImageView = UIImageView()
        auraImageView.frame.size           = frame.size
        auraImageView.contentMode          = .scaleAspectFill
        auraImageView.animationImages      = auraBlueImages
        auraImageView.animationRepeatCount = 0
        auraImageView.animationDuration    = 2.0
        auraImageView.startAnimating()
        
        addSubview(auraImageView)
    }
    
    fileprivate func addMonsterView() {
        let monsterView         = UIImageView()
        monsterView.frame.size  = frame.size
        monsterView.image       = UIImage(named: "img-orange")
        monsterView.contentMode = .scaleAspectFit
        addSubview(monsterView)
        
    }
    
    fileprivate func startBorderAnimation() {
        cardBorderView.alpha = 1
        addSubview(cardBorderView)
        UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.cardBorderView.alpha = 0
        }, completion: nil)
    }
    
    fileprivate func stopBorderAnimation() {
        cardBorderView.removeFromSuperview()
    }
    
}

// MARK: Public function
extension CardImageView {
    func openCard() {
        cardBackView.isHidden     = true
        cardBackAuraView.isHidden = true
        stopBorderAnimation()
    }
    
    func hideCard() {
        cardBackView.isHidden     = false
        cardBackAuraView.isHidden = false
        startBorderAnimation()
        
    }
}
