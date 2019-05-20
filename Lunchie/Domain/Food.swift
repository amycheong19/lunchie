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
}


struct Employee: Codable {
    var hasPickedUp: Bool = false
    var name: String = ""
    var selected_food: String = ""
    var path: String?
    var id: String = "" 
}




