//
//  CarTableCell.swift
//  WunderApp
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import UIKit

class CarTableCell: UITableViewCell {
    
    static let Key = "CarTableCell"
    
    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var carModel: CarModel? {
        didSet {
            configureViews()
        }
    }

    private func configureViews() {
        guard let carModel = carModel else { return }
        let placeholder = UIImage(named: "car_template") ?? UIImage()
        carImageView.image = placeholder
        modelLabel.text = carModel.vin ?? ""
        nameLabel.text = carModel.name ?? ""
        descriptionLabel.text = carModel.descriptionText()
    }
}
