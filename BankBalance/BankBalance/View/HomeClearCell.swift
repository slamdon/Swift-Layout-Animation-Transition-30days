//
//  HomeClearCell.swift
//  LabelNumbersAnimation
//
//  Created by don chen on 2017/3/9.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

protocol HomeClearCellDelegate {
    func didTapClear()
}

class HomeClearCell: UITableViewCell {

    @IBOutlet var clearButton: UIButton!
    
    var delegate:HomeClearCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearButton.layer.cornerRadius = 17.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didTapClear(_ sender: Any) {
        delegate?.didTapClear()
    }
    
}
