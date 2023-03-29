//
//  AddEditView.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 28/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import UIKit
protocol AddEditViewProtocol where Self: UIView {
    
    var tfBrand: UITextField { get set }
    var tfName: UITextField { get set }
    var tfPrice: UITextField { get set }
    var scGasType: UISegmentedControl { get set }
    var btAddEdit: UIButton {get set}
    var loading: UIActivityIndicatorView { get set }
    var pickerView: UIPickerView {get set}
}


class AddEditView: UIView, AddEditViewProtocol {

    //MARK: - Views
    lazy var tfBrand: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.placeholder = "Marca"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var tfName: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.placeholder = "Nome"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var tfPrice: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.placeholder = "Preço"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var scGasType: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["Flex", "Álcool", "Gasolina"])
        segControl.translatesAutoresizingMaskIntoConstraints = false
        return segControl
    }()
    
    lazy var btAddEdit: UIButton = {
        let btAddEdit = UIButton()
        btAddEdit.translatesAutoresizingMaskIntoConstraints = false
        btAddEdit.setTitleColor(.white, for: .normal)
        btAddEdit.backgroundColor = UIColor(named: "main")
        btAddEdit.setTitle("Cadastrar Carro", for: .normal)
        //btAddEdit.addTarget(self, action: #selector(addEdit(_:)), for: .touchUpInside)
        return btAddEdit
    }()
    
    lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            loading.activityIndicatorViewStyle = .large
        } else {
            // Fallback on earlier versions
        }
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    //MARK: - PickerViewSet
    lazy var pickerView: UIPickerView = {
        let pickerVIew = UIPickerView()
        pickerVIew.backgroundColor = .white
        return pickerVIew
    }()
    
    
    override init(frame: CGRect = .zero){
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddSubviews
    private func addSubviews() {
        addSubview(tfBrand)
        addSubview(tfName)
        addSubview(tfPrice)
        addSubview(scGasType)
        addSubview(btAddEdit)
        addSubview(loading)
    }
    
    //MARK: - Constraints
    private func configConstraints() {
        NSLayoutConstraint.activate([
            tfBrand.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            tfBrand.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tfBrand.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tfName.topAnchor.constraint(equalTo: tfBrand.bottomAnchor, constant: 12),
            tfName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tfName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tfPrice.topAnchor.constraint(equalTo: tfName.bottomAnchor, constant: 12),
            tfPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tfPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            scGasType.topAnchor.constraint(equalTo: tfPrice.bottomAnchor, constant: 12),
            scGasType.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scGasType.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            btAddEdit.topAnchor.constraint(equalTo: scGasType.bottomAnchor, constant: 20),
            btAddEdit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            btAddEdit.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            btAddEdit.heightAnchor.constraint(equalToConstant: 40),
            loading.topAnchor.constraint(equalTo: btAddEdit.bottomAnchor, constant: 40),
            loading.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loading.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
