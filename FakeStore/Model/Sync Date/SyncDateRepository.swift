//
//  SyncDaterepository.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation

protocol SyncDateRepository {
    func getLastSyncDate() -> SyncDate?
    func updateLastSyncDate(_ date: SyncDate)
}
