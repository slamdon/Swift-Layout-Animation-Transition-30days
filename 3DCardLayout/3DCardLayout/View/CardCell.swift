//
//  CardCell.swift
//  CardLayout
//
//  Created by don chen on 2017/2/1.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var data:Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 233/255, alpha: 1)
        layer.cornerRadius = 10
        layer.borderWidth = 4
        layer.borderColor = UIColor(red: 166/255, green: 126/255, blue: 128/255, alpha: 1).cgColor
        
        actionButton.layer.cornerRadius = 20
    }
    
    func loadContent() {
        if let model = data as? CardModel {
            imageView.image = model.image
            titleLabel.text = model.name
        }
    }

}
