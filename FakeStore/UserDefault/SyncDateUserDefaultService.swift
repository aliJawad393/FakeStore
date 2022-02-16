//
//  SyncDateUserDefaultService.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation

final class SyncDateUserDefaultService: SyncDateRepository {
    private let keySyncDate = "syncDate"
    
    func getLastSyncDate() -> SyncDate? {
        if let date = UserDefaults.standard.value(forKey: keySyncDate) as? Date {
            return SyncDate(date: date)
        }
        return nil
    }
    
    func updateLastSyncDate(_ syncDate: SyncDate) {
        UserDefaults.standard.set(syncDate.date, forKey: keySyncDate)
    }
}
