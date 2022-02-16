//
//  ProductListComposite.swift
//  FakeStore
//
//  Created by Ali Jawad on 17/02/2022.
//

import Foundation

final class ProductListComposite: ProductRepository {
    private let primarySource: ProductRepository
    private let secondarySource: ProductRepository
    
    //MARK: Init
    init(primarySource: ProductRepository, secondarySource: ProductRepository) {
        self.primarySource = primarySource
        self.secondarySource = secondarySource
    }
    
    func getProductsList(response: @escaping ((Result<[Product], Error>) -> Void)) -> Cancellable? {
        primarySource.getProductsList {[weak self] result in
            switch result {
            case .success(let products):
                response(.success(products))
            case .failure(_):
                self?.secondarySource.getProductsList(response: response)
            }
        }
    }
}
