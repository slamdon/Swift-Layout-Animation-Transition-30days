//
//  ImageSliderView.swift
//  ImageSlider
//
//  Created by don chen on 2017/12/23.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class ImageSliderView: UIImageView {
    
    var defaultDuration: CFTimeInterval = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ newImage:UIImage, animated: Bool) {
        if animated {
            let animation = CABasicAnimation(keyPath: "contents")
            animation.fromValue = image?.cgImage
            animation.toValue = newImage.cgImage
            animation.duration = defaultDuration
            
            layer.contents = image?.cgImage
            layer.add(animation, forKey: nil)
        }
        
        image = newImage
    }
    
}
