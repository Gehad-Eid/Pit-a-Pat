//
//  CountdownViewModel.swift
//  Test1
//
//  Created by Faizah Almalki on 12/07/1445 AH.
//

import Foundation
import SwiftUI
import AVFoundation

class CountdownViewModel: ObservableObject {
    @Published var counter = 10
    
    private var audioPlayer: AVAudioPlayer?

    func startCountdown() {
        if let soundPath = Bundle.main.path(forResource: "tick3", ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        }

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.counter > 0 {
                print("Counter: \(self.counter)")
                if self.counter == 6 {
                    self.audioPlayer?.play()
                }
                
                self.counter -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}
