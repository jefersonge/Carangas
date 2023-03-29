//
//  CustomTableViewCell.swift
//  Carangas
//
//  Created by Jeferson Dias dos Santos on 23/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier: String = "Cell"
    
    //MARK: - View
    let customView: UITableViewCell = {
        let view = UITableViewCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(customView)
        backgroundColor = .white
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Constraints
    private func configConstraints() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: self.topAnchor),
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
