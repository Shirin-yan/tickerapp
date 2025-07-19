//
//  TickerListView.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit
import SnapKit

class TickerListView: UIView {
    
    let contentStack = UIStackView(axis: .vertical,
                                   alignment: .fill,
                                   spacing: 0)
    
    let searchContainer = UIView()

    let search = SearchBarView(shouldFocusOnTap: false)
    
    let btnStack = UIStackView(axis: .horizontal,
                               alignment: .bottom,
                               spacing: 20,
                               edgeInsets: UIEdgeInsets(horizontal: 20),
                               backgroundColor: .systemBackground)
    
    let tickerTable = UITableView(style: .plain,
                                  rowHeight: UITableView.automaticDimension,
                                  estimatedRowHeight: 80,
                                  backgroundColor: .clear)
    
    let errorText = UILabel(font: .semibold(size: 16), color: .label, alignment: .center, text: "")
    
    private var searchHeightConstraint: Constraint!
    
    var tickerTypeBtns: [TickerListTypeBtn] = []
    var selectedBtn: TickerListType = .remote

    var isSearchHidden = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        tickerTable.register(TickerTbCell.self, forCellReuseIdentifier: TickerTbCell.id)
        
        setupView()
        setupTickerListBtns()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(contentStack)
        searchContainer.addSubview(search)
        
        contentStack.addArrangedSubviews([
            searchContainer,
            btnStack,
            tickerTable,
        ])
        
        contentStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview().inset(10)
        }
        
        search.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchContainer.snp.makeConstraints { make in
            searchHeightConstraint = make.height.equalTo(56).constraint
        }
        
        contentStack.addSubview(errorText)
        errorText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(160)
            make.height.equalTo(56)
        }
        
        btnStack.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
    
    func setupTickerListBtns(){
        TickerListType.allCases.forEach { type in
            let btn = TickerListTypeBtn(type: type)
            btn.isSelected = type == selectedBtn
            btn.clickCallback = { [weak self] in
                self?.selectedBtn = type
                self?.updateBtns()
                self?.tickerTable.reloadData()
            }
            
            tickerTypeBtns.append(btn)
        }
        
        btnStack.addArrangedSubviews(tickerTypeBtns)
        btnStack.addArrangedSubview(UIView())
    }
    
    func updateBtns(){
        tickerTypeBtns.forEach {
            $0.isSelected = selectedBtn == $0.type
        }
    }
    
    func hideSearchBar(animated: Bool = true) {
        isSearchHidden = true
        searchHeightConstraint.update(offset: 0)
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }

    func showSearchBar(animated: Bool = true) {
        isSearchHidden = false
        searchHeightConstraint.update(offset: 56)
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
}
