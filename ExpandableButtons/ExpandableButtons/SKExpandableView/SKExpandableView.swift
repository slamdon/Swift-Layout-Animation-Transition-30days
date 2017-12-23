//
//  SKExpandableView.swift
//  ExpandableButtons
//
//  Created by don chen on 2017/12/21.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

enum SKExpandableButtonType {
    case card
    case camera
    case box
    case book
}

protocol SKExpandableViewDelegate {
    func didTapExpandable(button:SKExpandableButtonType)
}

class SKExpandableView: UIView {
    private var buttons = [UIButton]()
    private var baseButton = UIButton()
    private var imageNames = ["icon-book", "icon-box", "icon-camera", "icon-card"]
    
    var delegate:SKExpandableViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        for i in 0..<imageNames.count {
            let name = imageNames[i]
            let button = UIButton(frame: CGRect(x: 0, y: 44 * i , width: 44, height: 44))
            button.setImage(UIImage(named:name), for: .normal)
            button.tag = i + 1
            button.addTarget(self, action: #selector(buttonTapHandler(button:)), for: .touchUpInside)
            addSubview(button)
            buttons.append(button)
        }
        
        baseButton.frame = CGRect(x: 0, y: 44 * 4, width: 44, height: 44)
        baseButton.setImage(UIImage(named:"icon-base"), for: .normal)
        baseButton.addTarget(self, action: #selector(buttonTapHandler(button:)), for: .touchUpInside)
        baseButton.tag = 0
        addSubview(baseButton)
    }
    
    private func switchMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            _ = self.buttons.map{
                ($0.alpha == 0) ? ($0.alpha = 1) : ($0.alpha = 0)
            }
        })
    }
    
    @objc private func buttonTapHandler(button:UIButton) {
        DispatchQueue.main.async {
            switch(button.tag){
                case 0: self.switchMenu()
                case 1: self.delegate?.didTapExpandable(button: .book)
                case 2: self.delegate?.didTapExpandable(button: .box)
                case 3: self.delegate?.didTapExpandable(button: .camera)
                case 4: self.delegate?.didTapExpandable(button: .card)
                default: break
            }
        }
    }
    
}
