//
//  UICollectionView.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit.UICollectionView

extension UICollectionView {
    convenience init( scrollDirection: ScrollDirection,
                      itemSize: CGSize? = nil,
                      estimatedItemSize: CGSize = CGSize(width: 200, height: 200),
                      headerReferenceSize: CGSize? = nil,
                      minimumLineSpacing: CGFloat = 0,
                      minimumInteritemSpacing: CGFloat = 0,
                      contentInsets: UIEdgeInsets = .zero,
                      backgroundColor: UIColor = .clear,
                      isPagingEnabled: Bool = false) {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.scrollDirection = scrollDirection
        layout.headerReferenceSize = headerReferenceSize ?? .zero
        layout.itemSize = itemSize ?? UICollectionViewFlowLayout.automaticSize
        if itemSize == nil {
            layout.estimatedItemSize = estimatedItemSize
        }
        
        self.init(frame: .zero, collectionViewLayout: layout)
        self.contentInset = contentInsets
        self.backgroundColor = backgroundColor
        self.isPagingEnabled = isPagingEnabled
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }

            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
