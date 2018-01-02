//
//  CardCollectionViewLayout.swift
//  CardLayout
//
//  Created by don chen on 2018/1/2.
//  Copyright © 2018年 Don Chen. All rights reserved.
//

import UIKit

class CardCollectionViewLayout: UICollectionViewLayout {
    // MARK: - Layout configuration
    
    public var itemSize: CGSize = CGSize(width: 250, height: 400) {
        didSet{
            invalidateLayout()
        }
    }
    
    public var spacing: CGFloat = 16.0 {
        didSet{
            invalidateLayout()
        }
    }
    
    public var maximumVisibleItems: Int = 4 {
        didSet{
            invalidateLayout()
        }
    }
    
    // MARK: UICollectionViewLayout
    override open func prepare() {
        super.prepare()
        assert(collectionView.numberOfSections == 1, "Multiple sections aren't supported!")
    }
    
    override open var collectionView: UICollectionView {
        return super.collectionView!
    }
    
    override open var collectionViewContentSize: CGSize {
        let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        return CGSize(width: collectionView.bounds.width * itemsCount,
                      height: collectionView.bounds.height)
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let totalItemsCount = collectionView.numberOfItems(inSection: 0)
        
        let minVisibleIndex = max(Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width), 0)
        let maxVisibleIndex = min(minVisibleIndex + maximumVisibleItems, totalItemsCount)
        
        let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        
        let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
        
        let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
        
        let visibleIndices = minVisibleIndex..<maxVisibleIndex
        
        let attributes: [UICollectionViewLayoutAttributes] = visibleIndices.map { index in
            let indexPath = IndexPath(item: index, section: 0)
            return computeLayoutAttributesForItem(indexPath: indexPath,
                                                  minVisibleIndex: minVisibleIndex,
                                                  contentCenterX: contentCenterX,
                                                  deltaOffset: CGFloat(deltaOffset),
                                                  percentageDeltaOffset: percentageDeltaOffset)
        }
        
        return attributes
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        let minVisibleIndex = Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width)
        let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
        let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
        return computeLayoutAttributesForItem(indexPath: indexPath,
                                              minVisibleIndex: minVisibleIndex,
                                              contentCenterX: contentCenterX,
                                              deltaOffset: CGFloat(deltaOffset),
                                              percentageDeltaOffset: percentageDeltaOffset)
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

// MARK: - Layout computations

extension CardCollectionViewLayout {
    
    private func scale(at index: Int) -> CGFloat {
        let translatedCoefficient = CGFloat(index) - CGFloat(self.maximumVisibleItems) / 2
        return CGFloat(pow(0.95, translatedCoefficient))
    }
    
    private func transform(atCurrentVisibleIndex visibleIndex: Int, percentageOffset: CGFloat) -> CGAffineTransform {
        var rawScale = visibleIndex < maximumVisibleItems ? scale(at: visibleIndex) : 1.0
        
        if visibleIndex != 0 {
            let previousScale = scale(at: visibleIndex - 1)
            let delta = (previousScale - rawScale) * percentageOffset
            rawScale += delta
        }
        return CGAffineTransform(scaleX: rawScale, y: rawScale)
    }
    
    fileprivate func computeLayoutAttributesForItem(indexPath: IndexPath,
                                                    minVisibleIndex: Int,
                                                    contentCenterX: CGFloat,
                                                    deltaOffset: CGFloat,
                                                    percentageDeltaOffset: CGFloat) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes(forCellWith:indexPath)
        let visibleIndex = indexPath.row - minVisibleIndex
        attributes.size = itemSize
        let midY = self.collectionView.bounds.midY
        attributes.center = CGPoint(x: contentCenterX + spacing * CGFloat(visibleIndex),
                                    y: midY + spacing * CGFloat(visibleIndex))
        attributes.zIndex = maximumVisibleItems - visibleIndex
        
        attributes.transform = transform(atCurrentVisibleIndex: visibleIndex,
                                         percentageOffset: percentageDeltaOffset)
        switch visibleIndex {
        case 0:
            attributes.center.x -= deltaOffset
            break
        case 1..<maximumVisibleItems:
            attributes.center.x -= spacing * percentageDeltaOffset
            attributes.center.y -= spacing * percentageDeltaOffset
            
            
            if visibleIndex == maximumVisibleItems - 1 {
                attributes.alpha = percentageDeltaOffset
            }
            break
        default:
            attributes.alpha = 0
            break
        }
        return attributes
    }
}
