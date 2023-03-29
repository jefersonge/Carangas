//
//  AddEditViewModel.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 19/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import Foundation

protocol AddEditViewModelDelegate{
    func reloadAllComponents()
    func goBack()
}

class AddEditViewModel {
 
    //MARK: - Varibles and Constants
    var brands: [Brand] = []
    var delegate: AddEditViewModelDelegate?
    var brandsUrlString = "https://parallelum.com.br/fipe/api/v1/carros/marcas#"
    let service = Service.shared
    
    //MARK: - Load Brands List
    func loadBrands() {
        guard let url = URL(string: brandsUrlString) else {return}
        service.loadBrands(url: url) { brands in
            if let brands = brands {
                self.brands = brands.sorted(by: {$0.nome < $1.nome})
                DispatchQueue.main.async {
                    self.delegate?.reloadAllComponents()
                }
            }
        }
    }
    //MARK: - Load Brand Unit
    func loadBrandUnity(row: Int) -> Brand {
       let brand = brands[row]
        return brand
    }
    
    //MARK: - Number Of Cars in Array
    var brandCount: Int {
        return brands.count
    }
    
    //MARK: - Save and UpdateCar
    func saveCar(car: Car) {
        service.save(basePath: K.basePath, car: car) { success in
            self.delegate?.goBack()
        }
    }
    
    func updateCar(car: Car) {
        service.update(basePath: K.basePath, car: car) { success in
            self.delegate?.goBack()
        }
    }
}
