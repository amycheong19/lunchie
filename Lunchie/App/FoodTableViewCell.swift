//
//  FoodTableViewCell.swift
//  Lunchie
//
//  Created by Amy Cheong on 19/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    struct Metric {
        static let collectionCellWidth: CGFloat = 100
        static let collectionCellHeight: CGFloat = 50
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var foodLabel: UILabel!

    var viewModel: FoodTableViewCellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionViewHeightConstraint.constant = self.getCollectionViewHeight() + 30
    }

    private func getCollectionViewHeight() -> CGFloat {
        let numberOfItemsPerRow = collectionView.bounds.width / Metric.collectionCellWidth
        let numberOfRow = ceil(CGFloat(viewModel.employees.count) / CGFloat(numberOfItemsPerRow))
        let height = numberOfRow * Metric.collectionCellHeight
        return height
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.employees.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmployeeCollectionViewCell.self), for: indexPath) as? EmployeeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let employee = viewModel.employees[indexPath.row]
        cell.nameLabel.text = employee.name
        cell.hasPickedUpFood = employee.hasPickedUp
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.updateFood(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: Metric.collectionCellWidth,
                          height: Metric.collectionCellHeight)
        return size
    }
}
