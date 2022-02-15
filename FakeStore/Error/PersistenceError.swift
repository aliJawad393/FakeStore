//
//  PersistenceError.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation

enum PersistanceError {
    case notFound
}

extension PersistanceError: Error { }
extension PersistanceError: LocalizedError {
    var errorDescription: String? {
            switch self {
            case .notFound:
                return NSLocalizedString("Query data not found", comment: "Error")
            }
        }
}
