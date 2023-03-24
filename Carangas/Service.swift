//
//  Rest.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 05/10/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

enum CarError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}


enum RESTOperation {
    case save
    case update
    case delete
}


struct Service {
    
    let basePath = "https://carangas.herokuapp.com/cars"
    static let shared = Service()
    
    //MARK: - Settings Session
    //Criado as configuracoes de corpo e  cabecalho para nao ser necessario adcionar em todos os metodos
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    //MARK: - Session
    let session = URLSession(configuration: configuration) //URLSession.shared
    
    
    
    
    func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping(ResponseType?, Error?) -> Void) {
            let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    
    //MARK: - LoadBrands
    //MARK - METODO CARREGAR AS MARCAS BEM COMPLETO, CARREGANDO ERROS CASO ACONTECAM, ERROS DEFINIDOS NO ENUM CARERROR
    func loadBrands(url: URL, onComplete: @escaping ([Brand]?) -> Void) {
        
        taskForGETRequest(url: url, response: [Brand].self) { response, error in
            if let brands = response {
                onComplete(brands)
            }
        }
    }
    
    //MARK: - LoadCars
    func loadCars(url: URL, onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        taskForGETRequest(url: url, response: [Car].self) { response, error in
            if let cars = response {
                onComplete(cars)
            }
        }
    }
    
    
    //MARK: - Save, Update and Delete Methods
    func save(basePath: String,car: Car, onComplete: @escaping (Bool) -> Void) {
        applyOperation(basePath: basePath, car: car, operation: .save, onComplete: onComplete)
    }
    
    func update(basePath: String,car: Car, onComplete: @escaping (Bool) -> Void) {
        applyOperation(basePath: basePath, car: car, operation: .update, onComplete: onComplete)
    }
    
    func delete(basePath: String,car: Car, onComplete: @escaping (Bool) -> Void) {
        applyOperation(basePath: basePath, car: car, operation: .delete, onComplete: onComplete)
    }
    
    //MARK: - SelectOperation
    //metodo criado para usar em save, update e delete
    func applyOperation(basePath: String, car: Car, operation: RESTOperation , onComplete: @escaping (Bool) -> Void) {
        var urlString = ""
        var httpMethod: String = ""
        
        switch operation {
        case .save:
            httpMethod = "POST"
            urlString = basePath
        case .update:
            httpMethod = "PUT"
            urlString = basePath + "/" + (car._id!)
        case .delete:
            httpMethod = "DELETE"
            urlString = basePath + "/" + (car._id!)
        }
        
        guard let url = URL(string: urlString) else {
            onComplete(false)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        
        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            }else {
                onComplete(false)
            }
        }
        dataTask.resume()
    }
}





