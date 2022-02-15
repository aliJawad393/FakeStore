//
//  ProductRouter.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation
import Foundation

enum ProductRouter {
    case productsList
}

extension ProductRouter: Router {
    var method: String {
        "GET"
    }
    
    var path: String {
        switch self {
        case .productsList:
            return "products"
        }
    }
    
    var parameters: [URLQueryItem]? {
        nil
    }
}
