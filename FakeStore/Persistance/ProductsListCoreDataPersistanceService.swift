//
//  ProductsListCoreDataService.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation
import CoreData

final class ProductsListCoreDataPersistanceService: ProductPersistance {
    //MARK: Vars
    private let managedObjectContext: NSManagedObjectContext
    
    //MARK: Init
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    private init() {
        fatalError("Can't be initialized without required parameters")
    }
    
    func saveProducts(_ products: [Product]) throws {
        for product in products {
            guard let entity =
                NSEntityDescription.entity(forEntityName: "ProductEntity",
                                           in: managedObjectContext), let newProduct = NSManagedObject(entity: entity,
                                                                                            insertInto: managedObjectContext) as? ProductEntity   else {
                fatalError("Failed to save")
            }
            newProduct.id = Int16(product.id)
            newProduct.price = product.price
            newProduct.category = product.category
            newProduct.imageUrl = product.imageUrl
            newProduct.title = product.title
            newProduct.productDescription = product.description
            newProduct.ratingNo = Int16(product.rating.count)
            newProduct.ratingValue = product.rating.rate
            
        }
        
        try managedObjectContext.save()
    }
    
    func deleteAllProducts() throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try managedObjectContext.execute(batchDeleteRequest)
        try managedObjectContext.save()
    }
    
    
}
