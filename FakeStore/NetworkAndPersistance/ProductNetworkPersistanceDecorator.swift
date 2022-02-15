//
//  ProductNetworkPersistanceDecorator.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation

final class ProductNetworkPersistanceDecorator: ProductRepository {
   
    //MARK: Vars
    private let network: ProductRepository
    private let persistance: ProductPersistance
    
    //MARK: Init
    init(network: ProductRepository, persistence: ProductPersistance) {
        self.network = network
        self.persistance = persistence
    }
    
    func getProductsList(response: @escaping ((Result<[Product], Error>) -> Void)) -> Cancellable? {
        network.getProductsList {[weak self] result in
            switch result {
            case .failure(let error):
                response(.failure(error))
            case .success(let products):
                response(.success(products))
                
                try? self?.persistance.deleteAllProducts()
                try? self?.persistance.saveProducts(products)
            }
        }
    }
    
}
