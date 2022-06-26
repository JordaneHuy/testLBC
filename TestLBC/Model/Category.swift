//
//  Category.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(cdCategory: CDCategory) {
        self.id = Int(cdCategory.id)
        self.name = cdCategory.name ?? ""
    }
}
