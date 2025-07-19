//
//  ListTypeBtn.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit

class TickerListTypeBtn: UIButton {

    var clickCallback: ( () -> Void )?
    let type: TickerListType
    
    override var isSelected: Bool {
        didSet {
            titleLabel?.font = isSelected ? .bold(size: 28) : .bold(size: 18)
        }
    }

    init(type: TickerListType) {
        self.type = type
        super.init(frame: .zero)
        addTarget(self, action: #selector(click), for: .touchUpInside)
        setTitle(type.title, for: .normal)
        setTitle(type.title, for: .selected)
        
        setTitleColor(.label, for: .selected)
        setTitleColor(.tertiaryLabel, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func click() {
        clickCallback?()
    }
}
