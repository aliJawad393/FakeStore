//
//  ProductsNetworkService.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation

final class ProductsNetworkService: Service, ProductRepository {
    @discardableResult
    func getProductsList(response: @escaping ((Result<[Product], Error>) -> Void)) -> Cancellable? {
        performRequest(request: ProductRouter.productsList) {[weak self] result in
            switch result {
            case .failure(let error):
                response(.failure(error))
            case .success(let data):
                if let products = self?.parser.parseResponse(data: data.0, response: [Product].self) {
                    print("Data fetch source: Network")
                    response(.success(products))
                } else {
                    response(.failure(NetworkError.parsingFailed))
                }
            }
        }
    }
}
