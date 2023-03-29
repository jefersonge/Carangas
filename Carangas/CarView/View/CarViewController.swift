//
//  ViewController.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 25/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import UIKit
import WebKit

class CarViewController: UIViewController {
    //MARK: - Setting UIView
    private var carView: CarViewProtocol
    
    init(carView: CarViewProtocol = CarView()) {
        self.carView = carView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = carView
    }

    //MARK: - BarButton Edit
    func buttonAdd () {
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(actionAdd))
        self.navigationItem.rightBarButtonItem  = addButton
    }
    
    
    //MARK: - Variables
    var car: Car!
    var viewModel: CarViewModel = CarViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAdd()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        setInfos()
        searchGoogle()
    }

    //MARK: - Methods
    func setInfos(){
        title = car.name
        carView.lbBrand.text = car.brand
        carView.lbGasType.text = car.gas
        carView.lbPrice.text = "R$ \(car.price)"
    }
    
    func searchGoogle(){
        viewModel.searchGoogle(car: car) { request in
            self.settingsWebView(request: request)
        }
    }
    
    func settingsWebView(request: URLRequest){
        carView.webView.allowsBackForwardNavigationGestures = true
        carView.webView.allowsLinkPreview = true
        carView.webView.navigationDelegate = self
        carView.webView.uiDelegate = self
        carView.webView.load(request)
        carView.loading.startAnimating()
    }
    
    //MARK: - Action BarButton Edit
    @objc func actionAdd () {
        let newViewController = AddEditViewController()
        navigationController?.pushViewController(newViewController, animated: true)
        newViewController.car = car
    }
}

//MARK: - Extension WKNavigationDelegate
extension CarViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        carView.loading.stopAnimating()
    }
}



