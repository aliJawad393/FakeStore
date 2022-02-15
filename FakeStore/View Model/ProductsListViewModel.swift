//
//  ProductsListViewModel.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation
import Combine

struct ProductPresenter {
    let id: Int
    let title: String
    let description: String
    let category: String
    let imageURL: URL?
    let price: String
    let rate: String
    let noOfRatings: String
    
    init(product: Product) {
        id = product.id
        title = product.title
        description = product.description
        category = product.category
        imageURL = URL(string: product.imageUrl)
        price = "$\(product.price)"
        rate = "\(product.rating.rate)"
        noOfRatings = "\(product.rating.count)"
    }
}

protocol ProductsListVM {
    var productsList: PassthroughSubject<[ProductPresenter], Never> {get}
    var error: PassthroughSubject<Error, Never> {get}
}

final class ProductsListViewModel: ProductsListVM {
    
    //MARK: Vars
    private let dataSource: ProductRepository
    let productsList = PassthroughSubject<[ProductPresenter], Never>()
    let error = PassthroughSubject<Error, Never>()
    
    //MARK: Init
    init(dataSource: ProductRepository) {
        self.dataSource = dataSource
    }
    
    func fetProrductsList() {
        dataSource.getProductsList {[weak self] response in
            switch response {
            case .success(let products):
                let mappedProucts = products.map{
                    ProductPresenter(product: $0)
                }
                self?.productsList.send(mappedProucts)
            case .failure(let err):
                self?.error.send(err)
            }
        }
    }
}
