//
//  HotelCardCell.swift
//  HotelCardLayout
//
//  Created by don chen on 2018/1/3.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HotelCardCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    var data:Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    func loadContent() {
        if let model = data as? HotelModel {
            backgroundColor = model.color
            nameLabel.text = model.name
            priceLabel.text = "$ \(model.price)"
        }
    }

}
