//
//  BaseBtn.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit

class BaseBtn: UIButton {
    
    var clickCallback: ( () -> Void )?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addTarget(self, action: #selector(click), for: .touchUpInside)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func click() {
        clickCallback?()
    }
}
