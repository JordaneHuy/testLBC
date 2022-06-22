//
//  Item.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation

struct Item {
    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Float
    let creationDate: Date
    //let images: ItemImage
    let isUrgent: Bool
}

extension Item: Codable {
    enum CodingKeys : String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case description
        case price
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
}
