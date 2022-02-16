//
//  Date+Ext.swift
//  FakeStore
//
//  Created by Ali Jawad on 17/02/2022.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd hh:mm"
        return dateFormatter.string(from: self)
    }
}
