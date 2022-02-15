//
//  UIViewControllerFactory.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation
import UIKit

protocol ViewControllerFactory {
    func createProductsListViewController() -> UIViewController
}

final class iOSViewControllerFactory: ViewControllerFactory {
    //MARK: Vars
    private let baseUrl: URL
    
    //MARK: Init
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func createProductsListViewController() -> UIViewController {
        ProductsListViewController(viewModel: ProductsListViewModel(dataSource: ProductsNetworkService(session: URLSession.shared, baseURL: baseUrl, parser: JSONParser()), networkNotifier: ReachabilityNetworkNotifier()))

    }
}
