//
//  DailyQuotaManager.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/23/24.
//

import Foundation
import Combine

class DailyQuotaManager: ObservableObject {
    @Published var timePlayedToday: TimeInterval = 0
    let dailyQuota: TimeInterval = 3600 // 60 minutes in seconds
    private var lastResetDate: Date?

    init() {
        loadQuota()
        resetQuotaIfNeeded()
    }
    
    func addPlaytime(seconds: TimeInterval) {
        timePlayedToday += seconds
        saveQuota()
    }
    
    func resetQuotaIfNeeded() {
        let now = Date()
        let lastReset = lastResetDate ?? now
        if !Calendar.current.isDate(now, inSameDayAs: lastReset) {
            timePlayedToday = 0
            lastResetDate = now
            saveQuota()
        }
    }
    
    private func loadQuota() {
        // Implement loading logic here, e.g., from UserDefaults or a database
    }
    
    private func saveQuota() {
        // Implement saving logic here, e.g., to UserDefaults or a database
    }
}

