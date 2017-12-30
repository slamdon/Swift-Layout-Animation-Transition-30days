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
    var cardView:CardImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Frame Animation"
        
        setupView()
    }

    
    fileprivate func setupView() {
        view.backgroundColor = UIColor.black
        
        cardView             = CardImageView(frame: CGRect(x: 0, y: 0, width: 123, height: 150))
        cardView.center      = CGPoint(x: view.frame.midX, y: view.frame.midY * 0.8)
        view.addSubview(cardView)
    }

    @IBAction func buttonClickHandler(_ sender: Any) {
        if controlButton.titleLabel?.text == "Open" {
            cardView.openCard()
            controlButton.setTitle("Hide", for: .normal)
            
        } else {
            cardView.hideCard()
            controlButton.setTitle("Open", for: .normal)
            
        }
    }
    
}
