//
//  AddEditViewController.swift
//  Carangas
//
//  Created by Eric Brito.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class OLDAddEditViewController: UIViewController {
    
    // MARK: - IBOutlets and Variables
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var viewModel = AddEditViewModel()
    var car: Car!
    
    //MARK: - PickerViewSet
    lazy var pickerView: UIPickerView = {
        let pickerVIew = UIPickerView()
        pickerVIew.backgroundColor = .white
        pickerVIew.delegate = self
        pickerVIew.dataSource = self
        return pickerVIew
    }()
    
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
       // setCarExists()
        //setToolbarBrandInput()
        
    }
    
    //MARK: - Methods
    func setCarExists(){
        if car != nil {
            tfBrand.text = car.brand
            tfName.text = car.name
            tfPrice.text = "\(car.price)"
            scGasType.selectedSegmentIndex = car.gasType
            btAddEdit.setTitle("Alterar carro", for: .normal)
        }
    }
    
    func setToolbarBrandInput(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.items = [btCancel, btSpace, btDone]
        tfBrand.inputAccessoryView = toolbar
        tfBrand.inputView = pickerView
        viewModel.loadBrands()
    }
    
    @objc func cancel() {
        tfBrand.resignFirstResponder()
    }
    @objc func done() {
        let brand = viewModel.loadBrandUnity(row: pickerView.selectedRow(inComponent: 0))
        tfBrand.text = brand.nome
        cancel()
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        
        sender.isEnabled = false
        sender.backgroundColor = .gray
        sender.alpha = 0.5
        loading.startAnimating()
        
        if car == nil {
            car = Car()
        }
        car.name = tfName.text!
        car.brand = tfBrand.text!
        car.price = Double(tfPrice.text ?? "0")!
        car.gasType = scGasType.selectedSegmentIndex
        
        if car._id == nil {
            viewModel.saveCar(car: car)
        } else {
            viewModel.updateCar(car: car)
        }
    }
}
//MARK: - PickerViewDelegate and DataSource

extension OLDAddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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

extension OLDAddEditViewController: AddEditViewModelDelegate{
    func goBack() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func reloadAllComponents() {
        self.pickerView.reloadAllComponents()
    }
}
