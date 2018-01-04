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
        minimumLineSpacing = -20.0
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let items = NSArray (array: super.layoutAttributesForElements(in: rect)!, copyItems: true)
        
        items.enumerateObjects(using: { (object, idex, stop) -> Void in
            let attributes = object as! UICollectionViewLayoutAttributes
            
//            if attributes.representedElementKind == UICollectionElementKindSectionHeader {
//                headerAttributes = attributes
//            }else {
//                self.updateCellAttributes(attributes)
//            }
            self.updateCellAttributes(attributes)
        })
        return items as? [UICollectionViewLayoutAttributes]
    }
    
//    func calculateAttributes() -> UICollectionViewLayoutAttributes? {
//        if collectionView == nil { return nil }
//        let minY = collectionView!.bounds.minY + collectionView!.contentInset.top
//
//
//    }
    
    func updateCellAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        let minY = collectionView!.bounds.minY + collectionView!.contentInset.top
        let maxY = attributes.frame.origin.y
        let finalY = max(minY, maxY)
        
        var origin = attributes.frame.origin
        origin.y = finalY
        attributes.frame = CGRect(origin: origin, size: attributes.frame.size)
        attributes.zIndex = attributes.indexPath.row
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
