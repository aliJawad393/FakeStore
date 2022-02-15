//
//  ProductRepository.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation

protocol ProductRepository {
    @discardableResult 
    func getProductsList(response: @escaping((Result<[Product], Error>) -> Void)) -> Cancellable?
}


protocol ProductPersistance {
    func saveProducts(_ products: [Product]) throws
    func deleteAllProducts() throws
}
