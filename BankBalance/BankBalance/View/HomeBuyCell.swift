//
//  HomeBuyCell.swift
//  LabelNumbersAnimation
//
//  Created by don chen on 2017/3/9.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

protocol HomeBuyCellDelegate {
    func didTapBuy(at:IndexPath)
}

class HomeBuyCell: UITableViewCell {
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var buyButton: UIButton!
    
    var delegate:HomeBuyCellDelegate?
    var cellIndexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.layer.cornerRadius = 17.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didTapBuy(_ sender: Any) {
        if cellIndexPath != nil {
            delegate?.didTapBuy(at: cellIndexPath!)
        }
    }
    
    func setupCell(price:Float) {
        priceLabel.text = "$ \(price)"
    }
    
    
}
