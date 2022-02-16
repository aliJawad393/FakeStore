//
//  ProductsListTableViewCellViewModel.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation
import Combine

protocol ProductsListTableViewCellViewModelDelegate: AnyObject {
    func didSeletedItemWithId(_ id: Int)
    func didRemoveItemWithId(_ id: Int)
}

final class ProductsListTableViewCellViewModel {
    
    //MARK: Vars
    let product: ProductPresenter
    var buttonTitle = CurrentValueSubject<String, Never>("Add")
    private var isItemAdded: Bool = false
    weak var delegate: ProductsListTableViewCellViewModelDelegate?
    
    //MARK: Init
    init(product: ProductPresenter) {
        self.product = product
    }
    
    //MARK: Internal Methods
    func didTapButton() {
        isItemAdded.toggle()
        isItemAdded ? buttonTitle.send("Remove") : buttonTitle.send("Add")
        isItemAdded ? delegate?.didSeletedItemWithId(product.id) : delegate?.didRemoveItemWithId(product.id)
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
