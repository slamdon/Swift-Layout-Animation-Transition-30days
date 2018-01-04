//
//  HotelCardCollectionViewFlowLayout.swift
//  HotelCardLayout
//
//  Created by don chen on 2018/1/3.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class HotelCardCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        if collectionView == nil { return }
        
        collectionView!.showsVerticalScrollIndicator = false
        
        itemSize = CGSize(width: collectionView!.bounds.width, height: 120)
        
        // make cards overlapping
        minimumLineSpacing = -20.0
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if super.layoutAttributesForElements(in: rect) == nil { return nil }
        
        var attributes = [UICollectionViewLayoutAttributes]()
        for attribute in super.layoutAttributesForElements(in: rect)! {
            let minY = collectionView!.bounds.minY + collectionView!.contentInset.top
            let maxY = attribute.frame.origin.y
            let newOrigin = CGPoint(x: attribute.frame.origin.x, y: max(minY, maxY))
            
            attribute.frame = CGRect(origin: newOrigin, size: attribute.frame.size)
            attribute.zIndex = attribute.indexPath.row
            attributes.append(attribute)
        }
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
