//
//  ParallexView.swift
//  ParallaxScrolling
//
//  Created by don chen on 2017/12/24.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class ParallexView: UIView {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
