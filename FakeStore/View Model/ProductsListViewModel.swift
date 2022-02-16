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
        category = product.category.capitalized
        imageURL = URL(string: product.imageUrl)
        price = "$\(product.price)"
        rate = "\(product.rating.rate)"
        noOfRatings = "\(product.rating.count)"
    }
}

protocol ProductsListVM {
    var productsList: PassthroughSubject<[ProductsListTableViewCellViewModel], Never> {get}
    var error: PassthroughSubject<Error, Never> {get}
    func fetchProrductsList()
}

final class ProductsListViewModel: ProductsListVM {
    
    //MARK: Vars
    private let dataSource: ProductRepository
    let productsList = PassthroughSubject<[ProductsListTableViewCellViewModel], Never>()
    let error = PassthroughSubject<Error, Never>()
    private var networkNotifier: NetworkNotifier
    
    //MARK: Init
    init(dataSource: ProductRepository, networkNotifier: NetworkNotifier) {
        self.dataSource = dataSource
        self.networkNotifier = networkNotifier
        self.networkNotifier.whenReachable = onNetworkReachable
        self.networkNotifier.whenUnreachable = onNetworkUnreachable
    }
    
    func fetchProrductsList() {
        dataSource.getProductsList {[weak self] response in
            switch response {
            case .success(let products):
                let mappedProucts = products.map{
                    ProductsListTableViewCellViewModel(product: ProductPresenter(product: $0))
                }
                self?.productsList.send(mappedProucts)
            case .failure(let err):
                self?.error.send(err)
            }
        }
    }
}

//MARK: Netwwork Reachability
private extension ProductsListViewModel {
    func onNetworkReachable() {
        print("Network reachable")
        fetchProrductsList()
        
    }
    
    func onNetworkUnreachable() {
        print("Network unreachable")
        error.send(NetworkError.networkUnreachable)
        
    }
}
