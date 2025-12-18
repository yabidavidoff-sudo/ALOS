//
//  CallKitManager.swift
//  ALOS
//
//  Created by yabi davidoff on 2025-12-17.
//


//
//  CallKitManager.swift
//  ALOS
//

import Foundation
import Combine

final class CallKitManager: ObservableObject {
    static let shared = CallKitManager()
    
    @Published var isCallActive: Bool = false
    
    func startCall(to agent: Agent) {
        isCallActive = true
        // TODO: real CallKit / WebRTC logic
    }
    
    func endCall() {
        isCallActive = false
        // TODO: real end-call logic
    }
}
