//
//  NetworkError.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation
enum NetworkError {
    case urlCreationFailed
    case parsingFailed
    case networkUnreachable
}

extension NetworkError: Error { }
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
            switch self {
            case .parsingFailed:
                return NSLocalizedString("Failed to parse response", comment: "Error")
            case .urlCreationFailed:
                return NSLocalizedString("Failed to create URL", comment: "Error")
            case .networkUnreachable:
                return NSLocalizedString("Network unreachable", comment: "Error")
            }
        }
}
