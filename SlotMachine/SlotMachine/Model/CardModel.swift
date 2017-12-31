//
//  CardModel.swift
//  SlotMachine
//
//  Created by don chen on 2017/12/31.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

enum CardLevel {
    case gray
    case green
    case blue
    case red
}

struct CardModel {
    var level:CardLevel
    var image:UIImage
}
