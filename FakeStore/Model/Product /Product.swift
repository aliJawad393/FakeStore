//
//  Product.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation

struct Product {
    let id: Int
    let title: String
    let price: Float
    let description: String
    let category: String
    let imageUrl: String
    let rating: Rating
}

struct Rating {
    let rate: Float
    let count: Int
}
