//
//  UIStackView.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit.UIStackView

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis,
                     alignment: Alignment,
                     spacing: CGFloat,
                     edgeInsets: UIEdgeInsets? = nil,
                     distribution: Distribution? = nil,
                     backgroundColor: UIColor? = nil,
                     cornerRadius: CGFloat? = nil) {
        
        self.init(frame: .zero)
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius ?? .zero
        
        if edgeInsets != nil {
            isLayoutMarginsRelativeArrangement = true
            layoutMargins = edgeInsets!
        }
        
        if distribution != nil {
            self.distribution = distribution!
        }
    }
    
    func addMargins(insets: UIEdgeInsets) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = insets
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func removeSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
