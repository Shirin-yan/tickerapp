//
//  UILabel.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit.UILabel

extension UILabel {
    convenience init(font: UIFont?,
                     color: UIColor,
                     alignment: NSTextAlignment = .left,
                     numOfLines: Int = 0,
                     text: String = "" ) {
        self.init(frame: .zero)
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = numOfLines
        self.text = text
    }
}
