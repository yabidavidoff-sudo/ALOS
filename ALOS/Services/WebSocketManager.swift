//
//  WebSocketManager.swift
//  ALOS
//

import Foundation
import Combine

class WebSocketManager: ObservableObject {
    @Published var isConnected: Bool = false
    @Published var notifications: [AgentNotification] = []
    
    static let shared = WebSocketManager()
    
    private init() {}
    
    func connect() {
        // TODO: Implement WebSocket connection
        isConnected = true
    }
    
    func disconnect() {
        isConnected = false
    }
}
