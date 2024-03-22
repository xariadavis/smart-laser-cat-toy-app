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
                    self.stopTimer()
                    self.countdownTime = self.totalTime // Reset or adjust as needed
                }
            }
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
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
