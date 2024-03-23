//
//  TimerViewModel.swift
//  SD App V4
//
//  Created by Xaria Davis on 3/19/24.
//

import Foundation
import Combine

class TimerViewModel: ObservableObject {
    @Published var countdownTime: TimeInterval
    private var totalTime: TimeInterval
    private var timer: AnyCancellable?
    @Published var sessionActive: Bool = false
    @Published var currentPattern: LaserPattern?

    init(countdownTime: TimeInterval) {
        self.countdownTime = countdownTime
        self.totalTime = countdownTime
    }
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.countdownTime > 0 {
                    self.countdownTime -= 1
                } else {
                    self.stopTimer() // TODO: Consider what to do when the timer hits 0
                }
            }
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    func startSession() {
        guard !sessionActive else { return }
        sessionActive = true
        startTimer()
    }

    func endSession() {
        guard sessionActive else { return }
        stopTimer()
        sessionActive = false
    }
    
    // Additional functionalities as needed, e.g., reset, pause, etc.
}

extension TimerViewModel {
    var formattedTime: String {
        let minutes = Int(countdownTime) / 60
        let seconds = Int(countdownTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
