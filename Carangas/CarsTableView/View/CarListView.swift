//
//  CarListView.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 27/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import UIKit

protocol CarListViewProtocol where Self: UIView {
    var tableView: UITableView { get set }
    var label: UILabel { get set }
}

class CarListView: UIView, CarListViewProtocol {

    
    //MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Carregando carros..."
        label.textColor = UIColor(named: "main")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddSubviews
    private func addSubviews() {
        addSubview(tableView)
        addSubview(label)
    }
    
    //MARK: - Constraints
    private func configConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
