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
    var totalPrice: CurrentValueSubject<Float, Never> {get}
    var lastSyncDate: CurrentValueSubject<String, Never> {get}
    func fetchProrductsList()
}

final class ProductsListViewModel: ProductsListVM {
    
    
    //MARK: Vars
    private let dataSource: ProductRepository
    let productsList = PassthroughSubject<[ProductsListTableViewCellViewModel], Never>()
    let error = PassthroughSubject<Error, Never>()
    let totalPrice = CurrentValueSubject<Float, Never>(0)
    private var networkNotifier: NetworkNotifier
    private var dataItems: [Product] = []
    private let userDefaultService: SyncDateUserDefaultService
    var lastSyncDate = CurrentValueSubject<String, Never>("")

    
    //MARK: Init
    init(dataSource: ProductRepository, userDefaultService: SyncDateUserDefaultService, networkNotifier: NetworkNotifier) {
        self.dataSource = dataSource
        self.networkNotifier = networkNotifier
        self.userDefaultService = userDefaultService
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
                mappedProucts.forEach { item in
                    item.delegate = self
                }
                self?.dataItems = products
                self?.productsList.send(mappedProucts)
                self?.lastSyncDate.send(self?.userDefaultService.getLastSyncDate()?.date.toString() ?? "")
            case .failure(let err):
                self?.error.send(err)
            }
        }
    }
}

//MARK: Netwwork Reachability
private extension ProductsListViewModel {
    func onNetworkReachable() {
        fetchProrductsList()
        
    }
    
    func onNetworkUnreachable() {
        error.send(NetworkError.networkUnreachable)
        
    }
}

//MARK: ProductsListTableViewCellViewModelDelegate
extension ProductsListViewModel: ProductsListTableViewCellViewModelDelegate {
    func didSeletedItemWithId(_ id: Int) {
        let item = dataItems.filter {
            $0.id == id
        }.first
        
        if let item = item {
            let prevTotal = totalPrice.value
            totalPrice.send(prevTotal + item.price)
        }
    }
    
    func didRemoveItemWithId(_ id: Int) {
        let item = dataItems.filter {
            $0.id == id
        }.first
        
        if let item = item {
            let prevTotal = totalPrice.value
            let newPrice = prevTotal - item.price
            totalPrice.send(newPrice >= 0 ? newPrice : 0)
        }
    }
    
    
}

