//
//  UIFont.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit.UIFont

extension UIFont {
    
    class func regular(size: CGFloat) -> UIFont? {
        UIFont(name: "Montserrat-Regular", size: size)
    }
    
    class func medium(size: CGFloat) -> UIFont? {
        UIFont(name: "Montserrat-Medium", size: size)
    }

    class func semibold(size: CGFloat) -> UIFont? {
        UIFont(name: "Montserrat-SemiBold", size: size)
    }

    class func bold(size: CGFloat) -> UIFont? {
        UIFont(name: "Montserrat-Bold", size: size)
    }
    
    class func black(size: CGFloat) -> UIFont? {
        UIFont(name: "Montserrat-Black", size: size)
    }
}
