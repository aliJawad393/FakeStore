//
//  UIViewControllerFactory.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation
import UIKit
import CoreData
import Reachability

protocol ViewControllerFactory {
    func createProductsListViewController() -> UIViewController
}

final class iOSViewControllerFactory: ViewControllerFactory {
    //MARK: Vars
    private let baseUrl: URL
    private let networkNotifier = ReachabilityNetworkNotifier()
    //MARK: Init
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func createProductsListViewController() -> UIViewController {
        let networkSource = ProductsNetworkService(session: URLSession.shared, baseURL: baseUrl, parser: JSONParser())
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        let persistanceService = ProductsListCoreDataPersistanceService(managedObjectContext: context)
        
        let coreDateWrapper = ProductNetworkPersistanceDecorator(network: networkSource, persistence: persistanceService)
        let userDefaultWrapper = ProductUserDefaultDecorator(network: coreDateWrapper, userDefaultService: SyncDateUserDefaultService())

        let composite = ProductListComposite(primarySource: userDefaultWrapper, secondarySource: ProductsListCoreDataService(managedObjectContext: context))
        let viewModel = ProductsListViewModel(dataSource: composite, userDefaultService: SyncDateUserDefaultService(), networkNotifier: networkNotifier)
        return ProductsListViewController(viewModel: viewModel, tableViewDelegate: TableViewDelegate(totalPriceObservable: viewModel.totalPrice.eraseToAnyPublisher(), lastSyncDateObservable: viewModel.lastSyncDate.eraseToAnyPublisher()))

    }
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FakeStore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
