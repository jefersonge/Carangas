//
//  CarView.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 28/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import UIKit
import WebKit

protocol CarViewProtocol where Self: UIView {
    
    var lbBrand: UILabel { get set }
    var lbGasType: UILabel { get set }
    var lbPrice: UILabel { get set }
    var webView: WKWebView { get set }
    var loading: UIActivityIndicatorView { get set }
}

class CarView: UIView, CarViewProtocol {
    
    
    //MARK: - Views
    lazy var lbBrand: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "A"
        label.textColor = UIColor(named: "main")
        label.textAlignment = .left
        return label
    }()
    
    lazy var lbGasType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    lazy var lbPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            loading.activityIndicatorViewStyle = .large
        }
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    override init(frame: CGRect = .zero){
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    //MARK: - AddSubviews
    private func addSubviews() {
        addSubview(lbBrand)
        addSubview(lbGasType)
        addSubview(lbPrice)
        addSubview(webView)
        addSubview(loading)
    }
    
    //MARK: - Constraints
    private func configConstraints() {
        NSLayoutConstraint.activate([
            lbBrand.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            lbBrand.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lbBrand.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lbGasType.topAnchor.constraint(equalTo: lbBrand.bottomAnchor, constant: 10 ),
            lbGasType.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lbPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lbPrice.topAnchor.constraint(equalTo: lbGasType.bottomAnchor, constant: 10 ),
            lbPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lbGasType.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            webView.topAnchor.constraint(equalTo: lbPrice.bottomAnchor, constant: 30 ),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.leadingAnchor.constraint(equalTo:leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
}
