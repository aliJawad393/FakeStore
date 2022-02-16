//
//  ProductsListTableViewCellViewModel.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation
import Combine

final class ProductsListTableViewCellViewModel {
    let product: ProductPresenter
    
    init(product: ProductPresenter) {
        self.product = product
    }
}

extension ProductsListTableViewCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
    }
    
    static func == (lhs: ProductsListTableViewCellViewModel, rhs: ProductsListTableViewCellViewModel) -> Bool {
        return lhs.product.id == rhs.product.id
    }
}
