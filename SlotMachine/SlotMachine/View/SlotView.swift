//
//  SlotView.swift
//  SlotMachine
//
//  Created by don chen on 2017/12/31.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class SlotView: UIView {
    private var cardBackView: UIImageView?
    private var cardBorderView: UIImageView?
    private var cardBackAuraView: UIImageView?
    private var cardAuraView: UIImageView?
    
    private var shineView:UIImageView?
    
    private var monsterScrollViewMask:UIView?
    private var monsterScrollView: UIView?
    
    private var auraBlueImages  = [UIImage]()
    private var auraRedImages   = [UIImage]()
    private var auraGrayImages  = [UIImage]()
    private var auraGreenImages = [UIImage]()
    
    var isScrolling:Bool =  false
    
    private var cards = [CardModel]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(frame: CGRect) { super.init(frame: frame) }
    
    init(frame: CGRect, cards:[CardModel]) {
        super.init(frame: frame)
        
        self.cards = cards
        setupAuraImages()
        setupView()
    }
    
    fileprivate func setupView() {
        isUserInteractionEnabled = true
        
        addAuraView()
        addMonsterView()
        addCardBackView()
        addShineView()
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
    

    
}

// MARK: Setup View
extension SlotView {
    fileprivate func addCardBackView() {
        cardBackView             = UIImageView()
        cardBackView!.frame.size  = frame.size
        cardBackView!.image       = UIImage(named: "img-card-back")!
        cardBackView!.contentMode = .scaleAspectFill
        addSubview(cardBackView!)
        
        cardBorderView = UIImageView()
        cardBorderView!.frame.size  = CGSize(width: cardBackView!.frame.size.width * 1.1,
                                             height: cardBackView!.frame.size.height * 1.1)
        cardBorderView!.center      = cardBackView!.center
        cardBorderView!.image       = UIImage(named: "img-card-border-white")!
        cardBorderView!.contentMode = .scaleAspectFit
        addSubview(cardBorderView!)
        
    }
    
    
    fileprivate func addAuraView() {
        cardBackAuraView                      = UIImageView()
        cardBackAuraView!.animationImages      = auraGrayImages
        cardBackAuraView!.frame.size           = CGSize(width: frame.size.width * 2.5, height: frame.size.height * 2.5)
        cardBackAuraView!.center               = center
        cardBackAuraView!.animationRepeatCount = 0
        cardBackAuraView!.animationDuration    = 2.0
        cardBackAuraView!.startAnimating()
        addSubview(cardBackAuraView!)
        
        cardAuraView = UIImageView()
        cardAuraView!.frame.size           = frame.size
        cardAuraView!.contentMode          = .scaleAspectFill
        cardAuraView!.animationRepeatCount = 0
        cardAuraView!.animationDuration    = 2.0
        cardAuraView!.isHidden = true
        addSubview(cardAuraView!)
    }
    
    fileprivate func addMonsterView() {
        monsterScrollViewMask = UIView()
        monsterScrollViewMask!.frame = frame
        monsterScrollViewMask?.clipsToBounds = true
        addSubview(monsterScrollViewMask!)
        
        let monsterScrollViewFrame = CGRect(x: 0, y: 0, width: frame.width * CGFloat(cards.count), height: frame.height)
        monsterScrollView = UIView(frame: monsterScrollViewFrame)
        monsterScrollViewMask?.addSubview(monsterScrollView!)
        
        for i in 0..<cards.count {
            let monsterFrame = CGRect(x: CGFloat(i) * frame.width, y: 0, width: frame.width, height: frame.height)
            let monsterLevelView = UIImageView(frame: monsterFrame)
            
            switch cards[i].level {
                case .gray: monsterLevelView.image = UIImage(named:"img-card-bg-gray")
                case .green: monsterLevelView.image = UIImage(named:"img-card-bg-green")
                case .blue: monsterLevelView.image = UIImage(named:"img-card-bg-blue")
                case .red: monsterLevelView.image = UIImage(named:"img-card-bg-red")
            }
            monsterScrollView?.addSubview(monsterLevelView)
            
            let monsterImageView = UIImageView(frame: monsterFrame)
            monsterImageView.image = cards[i].image
            monsterScrollView!.contentMode = .scaleAspectFit
            monsterScrollView!.addSubview(monsterImageView)
        }
    }
    
    fileprivate func addShineView() {
        let shineMask = UIView(frame: frame)
        shineMask.clipsToBounds = true
        addSubview(shineMask)
        
        shineView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width * 1.3, height: frame.height * 1.3))
        shineView?.center = center
        shineView!.image = UIImage(named:"img-card-shime")!
        shineView?.contentMode = .scaleAspectFill
        shineView!.alpha = 0.0
        shineMask.addSubview(shineView!)
    }
}

// MARK: Animation Function
extension SlotView {
    fileprivate func startBorderAnimation() {
        if cardBorderView == nil { return }
        
        cardBorderView!.alpha = 1
        addSubview(cardBorderView!)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.cardBorderView!.alpha = 0
        }, completion: nil)
    }
    
    fileprivate func stopBorderAnimation() {
        cardBorderView?.removeFromSuperview()
    }
    
    fileprivate func shineOnce() {
        shineView?.alpha = 1.0
        
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.shineView?.alpha = 0.0
        })
    }
    
    fileprivate func startScrollingSlot() {
        if monsterScrollView == nil { return }
        
        if isScrolling {
            return
        } else {
            isScrolling = true
        }
        
        shineOnce()
        
        // show border when scrolling
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        
        // reset position
        let originalFrame = monsterScrollView!.frame
        monsterScrollView!.frame = CGRect(x: 0, y: 0, width: originalFrame.width, height: originalFrame.height)
        
        let newFrame = CGRect(x: -self.frame.width * CGFloat(cards.count - 1),
                              y: 0,
                              width: self.frame.width,
                              height: self.frame.height)
        
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseOut, animations: {
            self.monsterScrollView!.frame = newFrame
            
        }, completion: { finished in
            self.isScrolling = false
            self.shineOnce()
            self.showCardAura()
            
            // hide border when scroll ended
            self.layer.borderWidth = 0.0
        })
        
    }
    
    private func showCardAura() {
        if cards.last == nil { return }
        if cardAuraView == nil { return }
        
        switch cards.last!.level {
            case .gray: cardAuraView?.animationImages = auraGrayImages
            case .green: cardAuraView?.animationImages = auraGreenImages
            case .blue: cardAuraView?.animationImages = auraBlueImages
            case .red: cardAuraView?.animationImages = auraRedImages
        }
        
        cardAuraView?.isHidden = false
        cardAuraView?.startAnimating()
    }
    
    private func hideCardAura() {
        cardAuraView?.stopAnimating()
        cardAuraView?.isHidden = true
    }
}

// MARK: Public function
extension SlotView {
    
    func openCard() {
        cardBackView?.isHidden     = true
        cardBackAuraView?.isHidden = true
        stopBorderAnimation()
        startScrollingSlot()
    }
    
    func hideCard() {
        cardBackView?.isHidden     = false
        cardBackAuraView?.isHidden = false
        hideCardAura()
        startBorderAnimation()
        
    }
}
