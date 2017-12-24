//
//  ProductInfoCell.swift
//  ExpandableTableView
//
//  Created by don chen on 2017/12/23.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class ProductInfoCell: UITableViewCell {
    
    fileprivate var nameLabel: UILabel!
    fileprivate var priceLabel: UILabel!
    var model:ProductModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let screen = UIScreen.main.bounds
        nameLabel      = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 60))
        self.addSubview(nameLabel)
        
        priceLabel               = UILabel(frame: CGRect(x: screen.width - 220, y: 0, width: 200, height: 60))
        priceLabel.textAlignment = .right
        self.addSubview(priceLabel)
        
        self.addSubview(UIView.CreateLine(CGRect(x: 0, y: 59.5, width: screen.width, height: 0.5), lineColor: UIColor.gray.alpha(0.1)))
    }
    
    func loadContent() {
        if model == nil {
            return
        }
        
        nameLabel.text = model!.name
        priceLabel.text  = "$\(model!.price)"
    }
    
    
    
    
}
