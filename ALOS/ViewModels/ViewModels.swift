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
//
//
//  CallViewModel.swift
//  ALOS
//

import Foundation
import Combine

class CallViewModel: ObservableObject {
    @Published var selectedAgent: Agent = .friday
    @Published var isInCall: Bool = false
    @Published var callDuration: TimeInterval = 0
    
    private var callTimer: Timer?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        CallKitManager.shared.$isCallActive
            .sink { [weak self] isActive in
                self?.isInCall = isActive
                if isActive {
                    self?.startCallTimer()
                } else {
                    self?.stopCallTimer()
                }
            }
            .store(in: &cancellables)
    }
    
    func startCall() {
        CallKitManager.shared.startCall(to: selectedAgent)
    }
    
    func endCall() {
        CallKitManager.shared.endCall()
    }
    
    private func startCallTimer() {
        callDuration = 0
        callTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.callDuration += 1
        }
    }
    
    private func stopCallTimer() {
        callTimer?.invalidate()
        callTimer = nil
        callDuration = 0
    }
}
//
//
//  AgentsViewModel.swift
//  ALOS
//

import Foundation

class AgentsViewModel: ObservableObject {
    @Published var agents: [Agent] = Agent.allCases
    @Published var selectedAgent: Agent?
    
    func testVoice(for agent: Agent) {
        VoiceManager.shared.speak(
            message: "Hello, I'm \(agent.rawValue.capitalized). How can I assist you?",
            agent: agent
        )
    }
    
    func callAgent(_ agent: Agent) {
        CallKitManager.shared.startCall(to: agent)
    }
    
    func getAgentDescription(for agent: Agent) -> String {
        switch agent {
        case .friday:
            return "Personal assistant & task manager"
        case .jarvis:
            return "Strategic advisor & decision support"
        case .atlas:
            return "Research & data analysis specialist"
        case .nova:
            return "Creative & innovation expert"
        }
    }
}
//
//
//  SettingsViewModel.swift
//  ALOS
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var backendURL: String
    @Published var voiceFeedbackEnabled: Bool
    @Published var autoAnswerCalls: Bool
    @Published var notificationsEnabled: Bool
    
    init() {
        // Load from UserDefaults
        self.backendURL = UserDefaults.standard.string(forKey: "backendURL") ?? ALOSConfig.API_BASE_URL
        self.voiceFeedbackEnabled = UserDefaults.standard.bool(forKey: "voiceFeedback")
        self.autoAnswerCalls = UserDefaults.standard.bool(forKey: "autoAnswer")
        self.notificationsEnabled = UserDefaults.standard.bool(forKey: "notifications")
    }
    
    func saveSettings() {
        UserDefaults.standard.set(backendURL, forKey: "backendURL")
        UserDefaults.standard.set(voiceFeedbackEnabled, forKey: "voiceFeedback")
        UserDefaults.standard.set(autoAnswerCalls, forKey: "autoAnswer")
        UserDefaults.standard.set(notificationsEnabled, forKey: "notifications")
    }
    
    func testConnection() {
        guard let url = URL(string: "\(backendURL)/health") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if error == nil {
                    print("✅ Connection successful")
                } else {
                    print("❌ Connection failed: \(error?.localizedDescription ?? "")")
                }
            }
        }.resume()
    }
}
