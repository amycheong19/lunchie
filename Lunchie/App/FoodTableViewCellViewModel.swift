//
//  FoodTableViewCellViewModel.swift
//  Lunchie
//
//  Created by Amy Cheong on 21/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation
import Firebase

class FoodTableViewCellViewModel {
    let db = Firestore.firestore()

    var updateFoodsDataHandler: (([IndexPath]) -> ())?
    private(set) var updateIndexPaths: [IndexPath] = [] {
        didSet {
            updateFoodsDataHandler?(updateIndexPaths)
        }
    }

    var employeesDataHandler: (([Employee]) -> ())?
    var employees: [Employee] = [] {
        didSet {
            employeesDataHandler?(employees)
        }
    }

    init(employees: [Employee]) {
        self.employees = employees
    }

    func updateFood(at indexPath: IndexPath) {
        var employee = employees[indexPath.row]
        employee.hasPickedUp = !employee.hasPickedUp
        if let data = try? JSONEncoder().encode(employee),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let dict = dictionary as? [String: Any] {
            db.document(employee.path!).updateData(dict)
        }
    }
}
