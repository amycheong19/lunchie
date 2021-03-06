//
//  FoodListViewModel.swift
//  Lunchie
//
//  Created by Amy Cheong on 17/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation
import Firebase

class FoodListViewModel {
    let db = Firestore.firestore()
    var originalFoodList: [Food] = []

    var getFoodsDataHandler: (([Food]) -> ())?
    private(set) var foodList: [Food] = [] {
        didSet {
            getFoodsDataHandler?(foodList)
        }
    }

    private(set) var employees: [Employee] = []

    init() {
        getFoodList()
    }

    func getFoodList() {
        // Get the latest lunch list 
        db.collection("lunches").order(by: "date", descending: true).limit(to: 1).getDocuments{ (snapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                var foodList: [Food] = []
                for doc in snapshot!.documents {
                    doc.reference.collection("food").getDocuments{ (snapshot, error) in
                        for doc in snapshot!.documents {
                            let data = try? JSONSerialization.data(withJSONObject: doc.data(), options: .prettyPrinted)
                            if let food = try? JSONDecoder().decode(Food.self, from: data!) {
                                foodList.append(food)
                            }
                        }
                        self.foodList = foodList.sorted(by: { $0.name < $1.name })
                        self.mergeFoodEmployeeList()
                        self.originalFoodList = self.foodList
                    }

                    doc.reference.collection("employees").addSnapshotListener{ (snapshot, error) in
                        var employees: [Employee] = []

                        for doc in snapshot!.documents {
                            let data = try? JSONSerialization.data(withJSONObject: doc.data(), options: .prettyPrinted)
                            if let employee = try? JSONDecoder().decode(Employee.self, from: data!) {
                                employees.append(employee)
                            }
                        }
                        self.employees = employees.sorted(by: { $0.name < $1.name })
                        self.mergeFoodEmployeeList()
                    }
                }
            }
        }

    }

    func searchFoodList(with keyword: String) {
        let keywordLowercased = keyword.lowercased()
        let filteredFoodDetails = foodList.filter {
                $0.name.lowercased().contains(keywordLowercased) ||
                $0.employees!.contains{ $0.name.lowercased().contains(keywordLowercased)
            }
        }

        foodList = filteredFoodDetails
    }

    func clearSearchFoodList(){
        foodList = originalFoodList
    }

    private func mergeFoodEmployeeList() {
        self.foodList = self.foodList.compactMap { food -> Food in
            var tempFood = food
            tempFood.employees = self.employees.filter{ $0.selected_food == food.id }
            return tempFood
        }
    }
}
