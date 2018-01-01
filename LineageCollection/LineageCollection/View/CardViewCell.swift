//
//  CardViewCell.swift
//  LineageCollection
//
//  Created by don chen on 2018/1/1.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var monsterImageView: UIImageView!
    
    var model:Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadContent() {
        if let data = model as? CardModel {
            switch data.level {
                case .gray:
                    bgImageView.image = UIImage(named: "img-card-bg-gray")
                
                case .green:
                    bgImageView.image = UIImage(named: "img-card-bg-green")
                
                case .blue:
                    bgImageView.image = UIImage(named: "img-card-bg-blue")
                
                case .red:
                    bgImageView.image = UIImage(named: "img-card-bg-red")
                
                default: break
            }
            monsterImageView.image = data.image
        }
        
    }

}
