//
//  ItemImage.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation

struct ItemImage {
    let small: String?
    let thumb: String?
}

extension ItemImage: Codable {
    enum CodingKeys : String, CodingKey {
        case small
        case thumb
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
    }
}
