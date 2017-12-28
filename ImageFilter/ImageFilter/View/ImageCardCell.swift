//
//  ImageCardCell.swift
//  ImageFilter
//
//  Created by don chen on 2017/12/28.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class ImageCardCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var data: Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
    }
    
    func loadContent(){
        if let model = data as? ImageCardModel {
            titleLabel.text = model.title
            imageView.image = model.image
        }
    }
    
    
    
    

}
