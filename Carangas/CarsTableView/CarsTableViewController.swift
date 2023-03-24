//
//  CarsTableViewController.swift
//  Carangas
//
//  Created by Eric Brito on 21/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    //MARK: - Variables
    var viewModel = CarsTableViewModel()
    var indexPathArray : [IndexPath] = []
    
    //MARK: - Label Loading
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        return label
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Carregando carros..."
        viewModel.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadCars()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSegue" {
            //segue ao clicar em um carro
            let vc = segue.destination as! CarViewController
            vc.car = viewModel.loadCarUnity(indexPatchRow: tableView.indexPathForSelectedRow!.row)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = viewModel.carsCount == 0 ? label : nil
        return viewModel.carsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let car = viewModel.loadCarUnity(indexPatchRow: indexPath.row)
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            indexPathArray = [indexPath]
            viewModel.deleteCar(indexPathRow: indexPath.row)
        }
    }
}
//MARK: - ExtensionViewModelDelegate
extension CarsTableViewController: CarsTableViewModelDelegate {

    func deleteRowCar() {
        self.tableView.deleteRows(at: indexPathArray, with: .fade)
    }
    
    func loadCarsAndReloadData() {
        self.label.text = "Não existem carros cadastrados."
        self.tableView.reloadData()
    }
}
