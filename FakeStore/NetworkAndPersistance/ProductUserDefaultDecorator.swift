//
//  ProductUserDefaultDecorator.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation

final class ProductUserDefaultDecorator: ProductRepository {
   /*
    Fetches data from provided data source and updates last sync date
    */
    //MARK: Vars
    private let network: ProductRepository
    private let userDefaultService: SyncDateUserDefaultService
    
    //MARK: Init
    init(network: ProductRepository, userDefaultService: SyncDateUserDefaultService) {
        self.network = network
        self.userDefaultService = userDefaultService
    }
    
    func getProductsList(response: @escaping ((Result<[Product], Error>) -> Void)) -> Cancellable? {
        network.getProductsList {[weak self] result in
            switch result {
            case .failure(let error):
                response(.failure(error))
            case .success(let products):
                response(.success(products))
                
                self?.userDefaultService.updateLastSyncDate(SyncDate(date: Date()))
            }
        }
    }
    
}
