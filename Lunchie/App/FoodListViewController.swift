//
//  ViewController.swift
//  Lunchie
//
//  Created by Amy Cheong on 15/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

class FoodListViewController: UITableViewController, ViewModelable {
    typealias ViewModel = FoodListViewModel
    var viewModel: ViewModel! = ViewModel()

    @IBOutlet weak var searchBar: UISearchBar!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        viewModel.getFoodsDataHandler = { [weak self] _ in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }

        viewModel.getEmployeesDataHandler = { [weak self] _ in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.foodList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodTableViewCell.self), for: indexPath) as? FoodTableViewCell else {
            return UITableViewCell()
        }
        let food = viewModel.foodList[indexPath.row]
        let employees = viewModel.employees.filter({ $0.selected_food == food.id })
        let viewModel = FoodTableViewCellViewModel(employees: employees)
        cell.viewModel =  viewModel
        cell.foodLabel.text = food.name
        cell.layoutIfNeeded()
        cell.collectionView.reloadData()
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.getFoodList()
    }
}

extension FoodListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, searchText.count >= 2 else {
            viewModel.clearSearchFoodList()
            return
        }
        viewModel.searchFoodList(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.clearSearchFoodList()
    }
}

