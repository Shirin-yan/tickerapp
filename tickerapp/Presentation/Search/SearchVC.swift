//
//  SearchVC.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit

class SearchVC: UIViewController {
    
    private var tags = ["Swift", "UIKit", "iOS", "Xcode", "SwiftUI", "Combine", "CoreData"]

    var viewModel = AppDIContainer.shared.makeSearchViewModel()
    
    var mainView: SearchView {
        return view as! SearchView
    }
    
    override func loadView() {
        super.loadView()
        view = SearchView()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallbacks()
        
        viewModel.loadSearchOptions()
        mainView.tickerTableView.dataSource = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
    
    func setupCallbacks(){
        mainView.search.backBtn.clickCallback = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        mainView.search.onReturn = { [weak self] searchText in
            self?.viewModel.loadSearchResults(searchText)
            self?.mainView.collectionView.isHidden = true
            self?.mainView.tickerTableView.isHidden = false
        }
        
        mainView.search.clearBtn.clickCallback = { [weak self] in
            self?.mainView.search.textField.text = ""
            self?.mainView.collectionView.isHidden = false
            self?.mainView.tickerTableView.isHidden = true
            self?.mainView.errorText.isHidden = true
            self?.mainView.errorText.text = ""
        }

        viewModel.onUpdateSearchOptions = { [weak self] in
            DispatchQueue.main.async {
                self?.mainView.errorText.isHidden = true
                self?.mainView.errorText.text = ""
                self?.mainView.collectionView.reloadData()
            }
        }
        
        viewModel.onUpdateTickers = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                if self.viewModel.searchResult.isEmpty {
                    self.mainView.errorText.isHidden = false
                    self.mainView.errorText.text = "No results found"
                } else {
                    self.mainView.errorText.isHidden = true
                    self.mainView.errorText.text = ""
                }
                
                self.mainView.tickerTableView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] error in
            guard let self else { return }
            DispatchQueue.main.async {
                self.mainView.errorText.isHidden = false
                self.mainView.errorText.text = error.localizedDescription
            }
        }
    }
}

extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.recentSearches.isEmpty ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? viewModel.popularSearches.count : viewModel.recentSearches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchChipHeaderView.id, for: indexPath) as! SearchChipHeaderView
        
        header.configure(with: indexPath.section == 0 ? "Popular requests" : "You’ve searched for this")
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCell.id, for: indexPath) as! ChipCell
        let title = indexPath.section == 0 ? viewModel.popularSearches[indexPath.item] : viewModel.recentSearches[indexPath.item]
        cell.configure(with: title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = indexPath.section == 0 ? viewModel.popularSearches[indexPath.item] : viewModel.recentSearches[indexPath.item]
        mainView.search.clearBtn.isHidden = false
        mainView.search.textField.text = title
        mainView.search.onReturn?(title)
    }
}

// MARK: Table View
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TickerTbCell.id, for: indexPath) as! TickerTbCell
        let ticker = viewModel.searchResult[indexPath.row]
        cell.configure(with: ticker)
        cell.setIsFavarite(viewModel.isSavedTicker(ticker))
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
