//
//  ChipCell.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit

class ChipCell: UICollectionViewCell {
    
    static let id = "ChipCell"
    
    let contentStack = UIStackView(axis: .vertical,
                                   alignment: .fill,
                                   spacing: 0,
                                   edgeInsets: UIEdgeInsets(horizontal: 16, vertical: 12),
                                   backgroundColor: .systemGray6,
                                   cornerRadius: 18)
    
    let text = UILabel(font: .semibold(size: 12),
                       color: .label,
                       alignment: .center,
                       numOfLines: 1,
                       text: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentStack.addArrangedSubview(text)
        text.setContentHuggingPriority(.required, for: .horizontal)
        text.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func configure(with data: String) {
        text.text = data
    }
}
