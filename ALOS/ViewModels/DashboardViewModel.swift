//
//  DashboardViewModel.swift
//  ALOS
//

import Foundation
import Combine

class DashboardViewModel: ObservableObject {
    @Published var systemStatus: String = "Initializing..."
    @Published var recentNotifications: [AgentNotification] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        // Subscribe to WebSocket manager
        WebSocketManager.shared.$notifications
            .sink { [weak self] notifications in
                self?.recentNotifications = Array(notifications.prefix(10))
            }
            .store(in: &cancellables)
        
        WebSocketManager.shared.$isConnected
            .sink { [weak self] isConnected in
                self?.systemStatus = isConnected ? "Connected" : "Offline"
            }
            .store(in: &cancellables)
    }
    
    func startVoiceCommand() {
        VoiceCommandManager.shared.startListening()
    }
    
    func callAgent(_ agent: Agent) {
        CallKitManager.shared.startCall(to: agent)
    }
}

