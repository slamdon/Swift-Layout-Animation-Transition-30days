//
//  CardCell.swift
//  CardLayout
//
//  Created by don chen on 2018/1/2.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    var imageName:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadContent() {
        if imageName == nil { return }
        if let image = UIImage(named:imageName!) {
            imageView.image = image
        }
        
        layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }

}
