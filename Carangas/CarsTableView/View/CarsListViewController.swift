//
//  ViewController.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 23/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import UIKit


class CarsListViewController: UIViewController {
    
    
    //MARK: - Setting UIView
    private var customView: CarListViewProtocol
    
    init(customView: CarListViewProtocol = CarListView()) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    
    //MARK: - BarButton Add
    func buttonAdd () {
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(actionAdd))
        self.navigationItem.rightBarButtonItem  = addButton
    }

    
    //MARK: - Variables and Constants
    let viewModel = CarsListViewModel()
    var indexPathArray : [IndexPath] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAdd()
        viewModel.delegate = self
        view.backgroundColor = .white
        self.title = "Carangas"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadCars()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }

    //MARK: - Action BarButtonAdd
    @objc func actionAdd () {
        let newViewController = AddEditViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

//MARK: - Extension UITableViewDelegate, UITableViewDataSource
extension CarsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.carsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: CustomTableViewCell.identifier)
        let car = viewModel.loadCarUnity(indexPatchRow: indexPath.row)
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            indexPathArray = [indexPath]
            viewModel.deleteCar(indexPathRow: indexPath.row)
        }
    }
    
    //MARK: - Go To NextView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.cars[indexPath.row].name)
        tableView.deselectRow(at: indexPath, animated: true)
        let newViewController = CarViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
        newViewController.car = viewModel.loadCarUnity(indexPatchRow: indexPath.row)
    }
    
}

//MARK: - ExtensionViewModelDelegate
extension CarsListViewController: CarsListViewModelDelegate {
    
    func deleteRowCar() {
        customView.tableView.deleteRows(at: indexPathArray, with: .fade)
    }
    
    func loadCarsAndReloadData() {
        if viewModel.carsCount < 1 {
            customView.label.text = "Não existem carros cadastrados."
        } else {
            customView.label.text = ""
        }
        customView.tableView.reloadData()
    }
}
