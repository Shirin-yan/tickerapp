//
//  UIEdgeInsets.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit

extension UIEdgeInsets {
    
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    init(all: CGFloat = 0) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
}
