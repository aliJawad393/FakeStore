//
//  ProductRepository.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation

protocol ProductRepository {
    func getProductsList(response: @escaping((Result<[Product], Error>) -> Void)) -> Cancellable?
}