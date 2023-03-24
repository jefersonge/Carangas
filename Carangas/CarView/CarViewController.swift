//
//  CarViewController.swift
//  Carangas
//
//  Created by Eric Brito on 21/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit
import Foundation
import WebKit


class CarViewController: UIViewController {

    enum url {
        case urlGoogle(String)
        
        var stringValue: String {
            switch self {
            case .urlGoogle(let name):
                return "https://www.google.com.br/search?q=\(name)&tbm=isch"
            }
        }
        var url: String{
            return String(stringValue)
        }
    }
    
    //MARK: - Outlets and Variables
    
    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var lbGasType: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var car: Car!

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInfos()
        searchGoogle()
    }
    
    //MARK: - Methods
    func setInfos(){
        title = car.name
        lbBrand.text = car.brand
        lbGasType.text = car.gas
        lbPrice.text = "R$ \(car.price)"
    }
    
    func searchGoogle(){
        let name = (title! + "+" + car.brand).replacingOccurrences(of: " ", with: "+")
        let urlString = url.urlGoogle(name).url
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        self.settingsWebView(request: request)
    }
    
    func settingsWebView(request: URLRequest){
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.load(request)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddEditViewController
        vc.car = car
    }
}

//MARK: - Extension WKNavigationDelegate
extension CarViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
