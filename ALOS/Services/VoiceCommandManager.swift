//
//  VoiceCommandManager.swift
//  ALOS
//

import Foundation

class VoiceCommandManager {
    static let shared = VoiceCommandManager()
    
    private init() {}
    
    func startListening() {
        print("Voice command listening started")
        // TODO: Implement voice recognition
    }
    
    func stopListening() {
        print("Voice command listening stopped")
    }
}
