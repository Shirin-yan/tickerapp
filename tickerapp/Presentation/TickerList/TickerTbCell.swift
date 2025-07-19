//
//  TickerTbCell.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit
import SnapKit

class TickerTbCell: UITableViewCell {
    
    static let id = "TickerTbCell"
    
    var contentStack = UIStackView(axis: .horizontal,
                                   alignment: .center,
                                   spacing: 12,
                                   edgeInsets: UIEdgeInsets(horizontal: 12, vertical: 8),
                                   cornerRadius: 16)
    
    let tickerImg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleStack = UIStackView(axis: .vertical,
                                 alignment: .fill,
                                 spacing: 4)
    
    let tickerStack = UIStackView(axis: .horizontal,
                                  alignment: .fill,
                                  spacing: 6)
    
    let ticker = UILabel(font: .bold(size: 18),
                         color: .label,
                         alignment: .left,
                         numOfLines: 0,
                         text: "")
    
    let title = UILabel(font: .medium(size: 11),
                        color: .label,
                        alignment: .left,
                        numOfLines: 1,
                        text: "")
    
    let addToFavBtn = BaseBtn()
    
    let priceStack = UIStackView(axis: .vertical,
                                 alignment: .fill,
                                 spacing: 4)
    
    
    let price = UILabel(font: .bold(size: 18),
                        color: .label,
                        alignment: .right,
                        numOfLines: 1,
                        text: "")
    
    let change = UILabel(font: .semibold(size: 12),
                         color: .label,
                         alignment: .right,
                         numOfLines: 1,
                         text: "")
    
    private var imageTask: URLSessionDataTask?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tickerImg.image = nil
        imageTask?.cancel()
        imageTask = nil
    }
    
    func setupView(){
        contentView.addSubview(contentStack)
        ticker.setContentHuggingPriority(.required, for: .horizontal)
        addToFavBtn.contentHorizontalAlignment = .leading

        contentStack.addArrangedSubviews([
            tickerImg,
            titleStack,
            priceStack
        ])
        
        titleStack.addArrangedSubviews([
            tickerStack,
            title
        ])
        
        tickerStack.addArrangedSubviews([
            ticker,
            addToFavBtn,
            UIView()
        ])
        
        priceStack.addArrangedSubviews([
            price,
            change
        ])
    }
    
    func setupConstraints(){
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
        }
        
        addToFavBtn.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(24)
        }
        
        tickerImg.snp.makeConstraints { make in
            make.size.equalTo(52)
        }
        
        ticker.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(24)
        }
    }
    
    func configure(with data: Ticker) {
        let priceValue = NumberFormatter.priceFormatter.string(from: NSNumber(value: data.price)) ?? "\(data.price)"
        loadImg(data.logo)
        ticker.text = data.symbol
        title.text = data.name
        price.text = priceValue
        change.text = "\(data.change > 0 ? "+" : "")\(data.change) (\(data.changePercent)%)"
        change.textColor = data.change > 0 ? .systemGreen : .systemRed
    }
    
    func setIsFavarite(_ isFavarite: Bool) {
        addToFavBtn.setImage(isFavarite ? UIImage(named: "star-filled") : UIImage(named: "star"), for: .normal)
    }
    
    func loadImg(_ urlString: String) {
        imageTask?.cancel()
        guard let url = URL(string: urlString) else { return }
        imageTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self,
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.tickerImg.image = image
            }
        }
        
        imageTask?.resume()
    }
}
