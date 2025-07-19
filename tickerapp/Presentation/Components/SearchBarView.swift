//
//  SearchBarView.swift
//  tickerapp
//
//  Created by  Shirin-Yan on 19.07.2025.
//

import UIKit

class SearchBarView: UIView {
    
    let contentStack = UIStackView(axis: .horizontal,
                                   alignment: .fill,
                                   spacing: 0,
                                   cornerRadius: 24)
    
    let backBtn: BaseBtn = {
        let b = BaseBtn()
        b.contentHorizontalAlignment = .center
        b.setImage(UIImage(named: "back-arrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        b.imageView?.tintColor = .label
        b.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        return b
    }()
    
    let searchBtn: BaseBtn = {
        let b = BaseBtn()
        b.contentHorizontalAlignment = .center
        b.setImage(UIImage(named: "search")?.withRenderingMode(.alwaysTemplate), for: .normal)
        b.imageView?.tintColor = .label
        b.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        return b
    }()
    
    let clearBtn: BaseBtn = {
        let b = BaseBtn()
        b.contentHorizontalAlignment = .center
        b.setImage(UIImage(named: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        b.imageView?.tintColor = .label
        b.isHidden = true
        b.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        return b
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Find company or ticker"
        tf.borderStyle = .none
        tf.returnKeyType = .search
        return tf
    }()
    
    private var shouldFocusOnTap = true
    
    var onTap: (() -> Void)?
    var onBack: (() -> Void)?
    var onReturn: ((String) -> Void)?
    
    init(shouldFocusOnTap: Bool = true) {
        super.init(frame: .zero)
        self.shouldFocusOnTap = shouldFocusOnTap
        setupView()
        setupViewPreferences()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textChanged() {
        clearBtn.isHidden = textField.text?.isEmpty ?? true
    }
    
    func setupView(){
        addSubview(contentStack)
        contentStack.layer.borderColor = UIColor.label.cgColor
        contentStack.layer.borderWidth = 1
        
        contentStack.addArrangedSubviews([
            searchBtn,
            backBtn,
            textField,
            clearBtn
        ])
        
        contentStack.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.edges.equalToSuperview().inset(UIEdgeInsets(horizontal: 16, vertical: 4))
        }
    }
    
    func setupViewPreferences(){
        textField.delegate = self
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        searchBtn.isHidden = shouldFocusOnTap
        backBtn.isHidden = !shouldFocusOnTap
        
        if shouldFocusOnTap {
            textField.becomeFirstResponder()
        }        
    }
}


extension SearchBarView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if shouldFocusOnTap {
            return true
        }
        
        onTap?()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBtn.isHidden = true
        backBtn.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        clearBtn.isHidden = textField.text?.isEmpty ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if !text.isEmpty {
            onReturn?(text)
        }
        return true
    }
}
