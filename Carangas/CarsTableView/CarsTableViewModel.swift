//
//  CarsTableViewModel.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 19/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import Foundation

protocol CarsTableViewModelDelegate {
    func loadCarsAndReloadData()
    func deleteRowCar()
}

class CarsTableViewModel {
    //MARK: - Variables and Constants
    var cars: [Car] = []
    var delegate: CarsTableViewModelDelegate?
    let service = Service.shared
    
    //MARK: - Load Car List
    func loadCars() {
        guard let url = URL(string: K.basePath) else {return}
        service.loadCars(url: url) { cars in
            self.cars = cars
            DispatchQueue.main.async {
                self.delegate?.loadCarsAndReloadData()
            }
        } onError: { (error) in
            print(error)
        }
    }
    //MARK: - Load Car Unity
    func loadCarUnity(indexPatchRow: Int)-> Car {
        let car = cars[indexPatchRow]
        return car
    }
    //MARK: - Number Of Cars in Array
    var carsCount: Int {
        return cars.count
    }
    
    //MARK: - Delete Selected Car
    func deleteCar(indexPathRow: Int){
    let car = cars[indexPathRow]
        service.delete(basePath: K.basePath, car: car) { sucess in
            if sucess {
                self.cars.remove(at: indexPathRow)
                DispatchQueue.main.async {
                    self.delegate?.deleteRowCar()
                }
            }
        }
    }
}
