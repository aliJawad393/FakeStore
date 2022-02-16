//
//  TableViewDelegate.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation
import UIKit
import Combine

final class TableViewDelegate: NSObject, UITableViewDelegate {
    
    //MARK: vars
    private let totalPriceObservable: AnyPublisher<Float, Never>
    
    //MARK: Init
    init(totalPriceObservable: AnyPublisher<Float, Never>) {
        self.totalPriceObservable = totalPriceObservable
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView(priceObservable: totalPriceObservable)
    }
}

