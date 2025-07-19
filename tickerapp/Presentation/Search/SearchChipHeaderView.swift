//
//  SearchChipHeaderView.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit

class SearchChipHeaderView: UICollectionReusableView {
    
    static let id = "SearchChipHeaderView"

    let title = UILabel(font: .bold(size: 18),
                        color: .label,
                        alignment: .left,
                        numOfLines: 0,
                        text: "")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with data: String) {
        title.text = data
    }
}

