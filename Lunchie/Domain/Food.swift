//
//  Food.swift
//  Lunchie
//
//  Created by Amy Cheong on 14/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation

struct Food: Codable {
    var id: String = ""
    var name: String = ""
    var employees: [Employee]? = []

//    init(name: String, employees: [Employee]? = nil) { // default struct initializer
//        self.name = name
//        self.employees = employees
//    }
//
//    enum MyStructKeys: String, CodingKey { // declaring our keys
//        case isVegetarian = "isVegetarian"
//        case name = "name"
//        case isHalal = "isHalal"
//        case employees = "employees"
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: MyStructKeys.self) // defining our (keyed) container
//        let name: String = try container.decode(String.self, forKey: .name) // extracting the data
//
//        self.init(name: name) // initializing our struct
//    }
}


struct Employee: Codable {
    var hasPickedUp: Bool = false
    var name: String = ""
    var selected_food: String = ""
    var path: String? 
}




