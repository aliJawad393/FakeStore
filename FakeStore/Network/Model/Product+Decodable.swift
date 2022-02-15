//
//  Product+Decodable.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation

extension Product: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        price = try values.decode(Float.self, forKey: .price)
        description = try values.decode(String.self, forKey: .description)
        category = try values.decode(String.self, forKey: .category)
        imageUrl = try values.decode(String.self, forKey: .image)
        rating = try values.decode(Rating.self, forKey: .rating)
    }
    
    enum Keys: String, CodingKey {
        case id, title, price, description, category,
             image, rating
    }
}

extension Rating: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        rate = try values.decode(Float.self, forKey: .rate)
        count = try values.decode(Int.self, forKey: .count)
    }
    
    enum Keys: String, CodingKey {
        case rate, count
    }
}
