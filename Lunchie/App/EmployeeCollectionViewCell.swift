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
            backgroundColor = hasPickedUpFood ? .red : .green
        }
    }

}
