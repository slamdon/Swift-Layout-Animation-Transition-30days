//
//  Card3DFlowLayout.swift
//  3DCardLayout
//
//  Created by don chen on 2018/1/6.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class Card3DFlowLayout: UICollectionViewFlowLayout {
    var previousOffset:CGFloat = 0
    var mainIndexPath:IndexPath?
    var movingInIndexPath:IndexPath?
    var difference:CGFloat = 0
    
    override func prepare() {
        super.prepare()
        setupLayout()
    }
    
    func setupLayout() {
        collectionView?.isPagingEnabled = true
        scrollDirection = .horizontal
        
        let inset:CGFloat = collectionView!.bounds.size.width * 0.12
        itemSize = CGSize(width: (collectionView!.bounds.size.width - 2 * inset),
                          height: collectionView!.bounds.size.height * 4/5)
        
        minimumLineSpacing = inset * 2
        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)
        applyTransformToLayoutAttributes(attribute: attributes!)
        
        return attributes
    }
    
    // indicate that we want to redraw as we scroll
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var cellIndices = self.collectionView!.indexPathsForVisibleItems
        
        if cellIndices.count == 0 {
            return attributes
            
        } else if cellIndices.count == 1 {
            mainIndexPath = cellIndices.first
            movingInIndexPath = nil
            
        } else if cellIndices.count > 1 {
            let firstIndexPath = cellIndices.first
            if firstIndexPath == mainIndexPath {
                movingInIndexPath = cellIndices[1]
            } else {
                movingInIndexPath = cellIndices.first
                mainIndexPath = cellIndices[1]
            }
        }
        
        difference = collectionView!.contentOffset.x - previousOffset
        previousOffset = collectionView!.contentOffset.x
        
        for attribute in attributes! {
            applyTransformToLayoutAttributes(attribute: attribute)
        }
        
        return attributes
        
    }
    
    func applyTransformToLayoutAttributes(attribute:UICollectionViewLayoutAttributes) {
        if attribute.indexPath.row == mainIndexPath?.row {
            let cell = collectionView!.cellForItem(at: mainIndexPath!)
            attribute.transform3D = transformFromView(view: cell!)
            
        } else if attribute.indexPath.row == movingInIndexPath?.row {
            let cell = collectionView!.cellForItem(at: movingInIndexPath!)
            attribute.transform3D = transformFromView(view: cell!)
        }
    }
    
    
}

// MARK:
extension Card3DFlowLayout {
    
    func transformFromView(view:UIView) -> CATransform3D {
        let angle = angleForView(view: view)
        let height = heightOffsetForView(view: view)
        let xAxis = xAxisForView(view: view)
        return transformFromAngle(angle: angle, height: height, xAxis: xAxis)
        
    }
    
    func transformFromAngle(angle:CGFloat, height:CGFloat, xAxis:Bool) -> CATransform3D {
        var t:CATransform3D = CATransform3DIdentity
        t.m34 = 1.0 / -500
        
        if xAxis {
            t = CATransform3DRotate(t, angle, 1, 1, 0)
        } else {
            t = CATransform3DRotate(t, angle, -1, 1, 0)
        }
        return t
    }
}

extension Card3DFlowLayout {
    
    func baseOffsetForView(view:UIView) -> CGFloat {
        let collectionViewCell = view as? UICollectionViewCell
        let offset = CGFloat(collectionView!.indexPath(for: collectionViewCell!)!.row) * collectionView!.bounds.size.width
        return offset
    }
    
    func heightOffsetForView(view:UIView) -> CGFloat {
        var height:CGFloat = 0
        let baseOffsetForCurrentView = baseOffsetForView(view: view)
        let currentOffset = collectionView!.contentOffset.x
        let scrollViewWidth = collectionView!.bounds.size.width
        
        height = CGFloat(120 * (currentOffset - baseOffsetForCurrentView) / scrollViewWidth)
        if height < 0 {
            height = -1 * height
        }
        
        return height
    }
    
    func angleForView(view:UIView) -> CGFloat {
        let baseOffsetForCurrentView = baseOffsetForView(view: view)
        let currentOffset = collectionView!.contentOffset.x
        let scrollViewWidth = collectionView!.bounds.size.width
        let angle = (currentOffset - baseOffsetForCurrentView) / scrollViewWidth
        return angle
    }
    
    func xAxisForView(view:UIView) -> Bool {
        let baseOffsetForCurrentView = baseOffsetForView(view: view)
        let currentOffset = collectionView!.contentOffset.x
        let offset = currentOffset - baseOffsetForCurrentView
        
        if offset >= 0 {
            return true
        } else {
            return false
        }
    }
}
