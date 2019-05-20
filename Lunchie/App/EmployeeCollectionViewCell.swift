//
//  EmployeeCollectionViewCell.swift
//  Lunchie
//
//  Created by Amy Cheong on 19/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

class EmployeeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    var hasPickedUpFood: Bool = false {
        didSet {
            backgroundColor = hasPickedUpFood ? #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            nameLabel.textColor = hasPickedUpFood ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1, green: 0.2371000051, blue: 0, alpha: 1)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderColor = #colorLiteral(red: 1, green: 0.2371000051, blue: 0, alpha: 1).cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 3.0
    }

}
