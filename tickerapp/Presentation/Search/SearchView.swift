//
//  SearchView.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit

class SearchView: UIView {
    
    let contentStack = UIStackView(axis: .vertical,
                                   alignment: .fill,
                                   spacing: 10)
    
    let search = SearchBarView()
    
    let collectionView = UICollectionView(scrollDirection: .vertical,
                                          estimatedItemSize: CGSize(width: 100, height: 40),
                                          headerReferenceSize: CGSize(width: UIScreen.main.bounds.width, height: 40),
                                          minimumLineSpacing: 8,
                                          minimumInteritemSpacing: 4,
                                          contentInsets: UIEdgeInsets(horizontal: 16, vertical: 8),
                                          isPagingEnabled: false)
    
    let tickerTableView = UITableView(style: .plain,
                                      rowHeight: UITableView.automaticDimension,
                                      estimatedRowHeight: 80,
                                      backgroundColor: .clear)
    
    let errorText = UILabel(font: .semibold(size: 16), color: .label, alignment: .center, text: "")

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(SearchChipHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SearchChipHeaderView.id)
        
        collectionView.register(ChipCell.self,
                                forCellWithReuseIdentifier: ChipCell.id)
        
        tickerTableView.register(TickerTbCell.self,
                                 forCellReuseIdentifier: TickerTbCell.id)
        
        tickerTableView.isHidden = true
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(contentStack)
        
        contentStack.addArrangedSubviews([
            search,
            collectionView,
            tickerTableView
        ])
        
        contentStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview().inset(10)
        }
        
        contentStack.addSubview(errorText)
        errorText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(160)
            make.height.equalTo(56)
        }
    }
}
