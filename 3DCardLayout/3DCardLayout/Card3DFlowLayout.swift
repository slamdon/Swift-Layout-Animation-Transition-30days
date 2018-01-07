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
    var difference:CGFloat     = 0
    var mainIndexPath:IndexPath?
    var movingInIndexPath:IndexPath?
    
    
    override func prepare() {
        super.prepare()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        collectionView?.isPagingEnabled = true
        scrollDirection = .horizontal
        
        let inset:CGFloat = collectionView!.bounds.size.width * 0.12
        itemSize = CGSize(width: (collectionView!.bounds.size.width - 2 * inset),
                          height: collectionView!.bounds.size.height * 4/5)
        
        minimumLineSpacing = inset * 2
        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
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
                // scroll left
                movingInIndexPath = cellIndices[1]
            } else {
                // scroll right
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
    
    fileprivate func applyTransformToLayoutAttributes(attribute:UICollectionViewLayoutAttributes) {
        if(collectionView == nil){ return }
        
        var cell:UICollectionViewCell?
        if attribute.indexPath.row == mainIndexPath?.row {
            cell = collectionView!.cellForItem(at: mainIndexPath!)
            attribute.transform3D = transformFromView(view: cell!)
            
        } else if attribute.indexPath.row == movingInIndexPath?.row {
            cell = collectionView!.cellForItem(at: movingInIndexPath!)
            attribute.transform3D = transformFromView(view: cell!)
            
        }
        
    }

    // render when we scroll
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

// MARK: Calculates
extension Card3DFlowLayout {
    
    fileprivate func transformFromView(view:UICollectionViewCell) -> CATransform3D {
        let angle = angleForView(view: view)
        return transformFromAngle(angle: angle, with: view)
        
    }
    
    fileprivate func angleForView(view:UICollectionViewCell) -> CGFloat {
        let baseOffsetForCurrentView = CGFloat(collectionView!.indexPath(for: view)!.row) * collectionView!.bounds.size.width
        let currentOffset = collectionView!.contentOffset.x
        let scrollViewWidth = collectionView!.bounds.size.width
        let angle = (currentOffset - baseOffsetForCurrentView) / scrollViewWidth
        return angle
    }
    
    fileprivate func transformFromAngle(angle:CGFloat, with view:UICollectionViewCell) -> CATransform3D {
        var transform:CATransform3D = CATransform3DIdentity
        transform.m34 = 1.0 / -500
        
        let baseOffsetForCurrentView = CGFloat(collectionView!.indexPath(for: view)!.row) * collectionView!.bounds.size.width
        let currentOffset = collectionView!.contentOffset.x
        let offset = currentOffset - baseOffsetForCurrentView
        var isScrollingLeft = false
        if offset >= 0 { isScrollingLeft = true }
        
        if isScrollingLeft {
            transform = CATransform3DRotate(transform, angle, 1.0, 1.0, 0.0)
        } else {
            transform = CATransform3DRotate(transform, angle, -1.0, 1.0, 0.0)
        }
        return transform
    }
    

}
