//
//  CardModel.swift
//  LineageCollection
//
//  Created by don chen on 2018/1/1.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

enum CardLevel {
    case all
    case gray
    case green
    case blue
    case red
}

struct CardModel {
    var level:CardLevel
    var image:UIImage
}
