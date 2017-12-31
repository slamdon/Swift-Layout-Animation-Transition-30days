//
//  HomeViewController.swift
//  FrameAnimation
//
//  Created by don chen on 2017/12/30.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var controlButton: UIButton!
    var slotView:SlotView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Frame Animation"
        
        setupView()
    }

    
    fileprivate func setupView() {
        view.backgroundColor = UIColor.black
 
        var cards = [CardModel]()
        for i in 1...36 {
            var cardLevel:CardLevel = .gray
            switch i % 4 {
                case 0: cardLevel = .red
                case 1: cardLevel = .blue
                case 2: cardLevel = .green
                case 3: cardLevel = .gray
                default: break;
            }
            
            let card = CardModel(level: cardLevel, image: UIImage(named: "monster-\(i)")!)
            cards.append(card)
        }
        
        slotView = SlotView(frame: CGRect(x: 0, y: 0, width: 123, height: 150), cards: cards)
        slotView.center = CGPoint(x: view.frame.midX, y: view.frame.midY * 0.8)
        view.addSubview(slotView)
    }

    @IBAction func buttonClickHandler(_ sender: Any) {
        if controlButton.titleLabel?.text == "Open" {
            slotView.openCard()
            controlButton.setTitle("Hide", for: .normal)
            
        } else {
            slotView.hideCard()
            controlButton.setTitle("Open", for: .normal)
            
        }
    }
    
}
