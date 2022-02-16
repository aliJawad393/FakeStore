//
//  ProductsListCoreDataService.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation
import CoreData

final class ProductsListCoreDataService: ProductRepository {
    
    //MARK: Vars
    private let managedObjectContext: NSManagedObjectContext
    
    //MARK: Init
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func getProductsList(response: @escaping ((Result<[Product], Error>) -> Void)) -> Cancellable? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do {
            if let results   = try managedObjectContext.fetch(fetchRequest) as? [ProductEntity] {
                let productsReturn = results.map {item in
                    Product(coreDataItem: item)
                }
                print("Data fetch source: Local database")
                response(.success(productsReturn))
            } else {
                response(.failure(PersistanceError.notFound))
            }
        } catch let error as NSError {
            response(.failure(error))
        }

        return nil
    }
}

private extension Product {
    init(coreDataItem: ProductEntity) {
        id = Int(coreDataItem.id)
        title = coreDataItem.title ?? ""
        description = coreDataItem.productDescription ?? ""
        category = coreDataItem.category ?? ""
        price = coreDataItem.price
        imageUrl = coreDataItem.imageUrl ?? ""
        rating = Rating(rate: coreDataItem.ratingValue , count: Int(coreDataItem.ratingNo))
    }
}
