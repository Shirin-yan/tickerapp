//
//  TickerListVC.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit

enum TickerListType: CaseIterable {
    case remote
    case saved
    
    var title: String {
        switch self {
        case .remote:
            return "Stocks"
        case .saved:
            return "Favorite"
        }
    }
}


class TickerListVC: UIViewController {
    
    let viewModel = AppDIContainer.shared.makeTickerListViewModel()

    var isRemoteListSelected = true
    var lastContentOffset: CGFloat = 0
    var accumulatedDelta: CGFloat = 0

    var mainView: TickerListView {
        return view as! TickerListView
    }
    
    override func loadView() {
        super.loadView()
        view = TickerListView()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupCallbacks()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadTickers()
    }
    
    func setupCallbacks(){
        mainView.search.onTap = { [weak self] in
            self?.navigationController?.pushViewController(SearchVC(), animated: true)
        }
        
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.mainView.errorText.isHidden = true
                self?.mainView.tickerTable.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.mainView.errorText.isHidden = false
                self?.mainView.errorText.text = error.localizedDescription
            }
        }
    }
    
    func setupData(){
        mainView.tickerTable.delegate = self
        mainView.tickerTable.dataSource = self

        viewModel.loadTickers()
    }
}

// MARK: Table View
extension TickerListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mainView.selectedBtn {
        case .remote:
            return viewModel.remoteTickers.count
        case .saved:
            return viewModel.localTickers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TickerTbCell.id, for: indexPath) as! TickerTbCell
        let ticker: Ticker!
        switch mainView.selectedBtn {
        case .remote:
            ticker = viewModel.remoteTickers[indexPath.row]
            cell.configure(with: ticker)
            cell.setIsFavarite(viewModel.isSavedTicker(ticker))

        case .saved:
            ticker = viewModel.localTickers[indexPath.row]
            cell.configure(with: ticker)
            cell.setIsFavarite(true)
        }
        
        cell.addToFavBtn.clickCallback = { [weak self] in
            guard let self else { return }
            if self.viewModel.isSavedTicker(ticker) {
                self.viewModel.deleteTicker(ticker)
            } else {
                self.viewModel.saveTicker(ticker)
            }
        }
        cell.contentStack.backgroundColor = indexPath.row%2 == 0 ? .clear : .systemGray6
        return cell
    }
}

// MARK: Search bar show/hide logic
extension TickerListVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y

        // Force show at top
        if currentOffset <= 0 {
            showSearch()
            return
        }
        
        // Don't do anything if at bottom
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if currentOffset >= maxOffset {
            lastContentOffset = currentOffset
            return
        }

        let delta = currentOffset - lastContentOffset

        // Update accumulation only if direction is consistent
        if (delta > 0 && accumulatedDelta >= 0) || (delta < 0 && accumulatedDelta <= 0) {
            accumulatedDelta += delta
        } else {
            accumulatedDelta = delta // direction changed
        }

        // Trigger hide/show based on accumulated delta threshold
        if accumulatedDelta > 30, !mainView.isSearchHidden {
            mainView.hideSearchBar()
            accumulatedDelta = 0
        } else if accumulatedDelta < -20, mainView.isSearchHidden {
            showSearch()
        }

        lastContentOffset = currentOffset
    }
    
    func showSearch(){
        guard mainView.isSearchHidden else { return }
        mainView.showSearchBar()
        accumulatedDelta = 0
    }
}
