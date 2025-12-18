//
//  VoiceManager.swift
//  ALOS
//

import Foundation
import Combine

class VoiceManager: ObservableObject {
    @Published var isListening: Bool = false
    @Published var lastCommand: String = ""
    
    static let shared = VoiceManager()
    
    private init() {}
    
    func startListening() {
        isListening = true
    }
    
    func stopListening() {
        isListening = false
    }
}
