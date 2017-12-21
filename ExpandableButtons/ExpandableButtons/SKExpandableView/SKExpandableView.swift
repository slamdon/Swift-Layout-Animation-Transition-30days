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
    private var baseButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
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
            let button = UIButton(frame: CGRect(x: 0, y: -i * 44 - 44, width: 44, height: 44))
            button.setImage(UIImage(named:name), for: .normal)
            button.tag = i + 1
            button.addTarget(self, action: #selector(buttonTapHandler(tapGestureRecognizer:)), for: .touchUpInside)
        
            
            addSubview(button)
            buttons.append(button)
        }
        
        baseButton.setImage(UIImage(named:"icon-base"), for: .normal)
        baseButton.addTarget(self, action: #selector(buttonTapHandler(tapGestureRecognizer:)), for: .touchUpInside)
        baseButton.tag = 0
        addSubview(baseButton)
        
        isUserInteractionEnabled = true
        
    }
    
    private func switchExpandableStackView() {
        UIView.animate(withDuration: 0.3, animations: {
            _ = self.buttons.map{ $0.isHidden = !$0.isHidden }
        })
    }
    
    private func buttonTapHandler(button:UIButton) {
        print("did tap button \(button.tag)")
    }
    
    @objc private func buttonTapHandler(tapGestureRecognizer: UITapGestureRecognizer) {
        print("did tap")
        if let tag = tapGestureRecognizer.view?.tag {
            DispatchQueue.main.async {
                switch(tag){
                case 0: self.switchExpandableStackView()
                case 1: self.delegate?.didTapExpandable(button: .card)
                case 2: self.delegate?.didTapExpandable(button: .camera)
                case 3: self.delegate?.didTapExpandable(button: .box)
                case 4: self.delegate?.didTapExpandable(button: .book)
                default: break
                }
            }
        }
        
    }
    
}
