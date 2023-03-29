//
//  CarViewModel.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 28/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import Foundation

class CarViewModel {
    
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
    
    
    func searchGoogle(car: Car, completion: @escaping(URLRequest)-> Void){
        let name = (car.name + "+" + car.brand).replacingOccurrences(of: " ", with: "+")
        let urlString = url.urlGoogle(name).url
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        completion(request)
    }
}
