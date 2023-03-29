//
//  AddEditViewController.swift
//  Carangas
//
//  Created by Eric Brito.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {
    
    
    //MARK: - Setting UIView
    private var customView: AddEditViewProtocol
    
    init(customView: AddEditViewProtocol = AddEditView()) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    
    //MARK: - Variables
    var viewModel = AddEditViewModel()
    var car: Car!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        //        addSubviews()
        //        configConstraints()
        setCarExists()
        setToolbarBrandInput()
        customView.btAddEdit.addTarget(self, action: #selector(addEdit(_:)), for: .touchUpInside)
    }
    
    //
    //MARK: - Methods
    func setCarExists(){
        if car != nil {
            customView.tfBrand.text = car.brand
            customView.tfName.text = car.name
            customView.tfPrice.text = "\(car.price)"
            customView.scGasType.selectedSegmentIndex = car.gasType
            customView.btAddEdit.setTitle("Alterar carro", for: .normal)
        }
    }
    
    func setToolbarBrandInput(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.items = [btCancel, btSpace, btDone]
        customView.pickerView.delegate = self
        customView.pickerView.dataSource = self
        customView.tfBrand.inputAccessoryView = toolbar
        customView.tfBrand.inputView = customView.pickerView
        viewModel.loadBrands()
    }
    
    @objc func cancel() {
        customView.tfBrand.resignFirstResponder()
    }
    @objc func done() {
        let brand = viewModel.loadBrandUnity(row: customView.pickerView.selectedRow(inComponent: 0))
        customView.tfBrand.text = brand.nome
        cancel()
    }
    
    // MARK: - Action btAddEdit
    @objc func addEdit(_ sender: UIButton) {
        
        sender.isEnabled = false
        sender.backgroundColor = .gray
        sender.alpha = 0.5
        customView.loading.startAnimating()
        
        if car == nil {
            car = Car()
        }
        car.name = customView.tfName.text!
        car.brand = customView.tfBrand.text!
        car.price = Double(customView.tfPrice.text ?? "0")!
        car.gasType = customView.scGasType.selectedSegmentIndex
        
        if car._id == nil {
            viewModel.saveCar(car: car)
        } else {
            viewModel.updateCar(car: car)
        }
    }
}

//MARK: - PickerViewDelegate and DataSource

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.brandCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let brand = viewModel.loadBrandUnity(row: row)
        return brand.nome
    }
    
}
//MARK: - AddEditViewModelDelegate
extension AddEditViewController: AddEditViewModelDelegate{
    func goBack() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func reloadAllComponents() {
        customView.pickerView.reloadAllComponents()
    }
}
