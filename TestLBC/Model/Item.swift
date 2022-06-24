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
    let images: ItemImage
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
        case images = "images_url"
        case isUrgent = "is_urgent"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        categoryId = try values.decode(Int.self, forKey: .categoryId)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        price = try values.decode(Float.self, forKey: .price)
        creationDate = try values.decode(Date.self, forKey: .creationDate)
        images = try values.decode(ItemImage.self, forKey: .images)
        isUrgent = try values.decode(Bool.self, forKey: .isUrgent)
    }
}
