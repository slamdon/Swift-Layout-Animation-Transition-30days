//
//  HomeCell.swift
//  ExpandTransition
//
//  Created by don chen on 2018/1/9.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    var itemImage:UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func loadContent() {
        if itemImage != nil {
            itemImageView.image = itemImage!
        }
    }
    
}
