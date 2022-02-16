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
    private let lastSyncDateObservable: AnyPublisher<String, Never>
    
    //MARK: Init
    init(totalPriceObservable: AnyPublisher<Float, Never>, lastSyncDateObservable: AnyPublisher<String, Never>) {
        self.totalPriceObservable = totalPriceObservable
        self.lastSyncDateObservable = lastSyncDateObservable
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView(priceObservable: totalPriceObservable)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return FooterView(lastSyncDateObservable: lastSyncDateObservable)
    }
}

