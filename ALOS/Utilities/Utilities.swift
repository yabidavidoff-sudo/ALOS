//
//  Config.swift
//  ALOS
//

import Foundation

struct ALOSConfig {
    // Backend configuration
    static let BACKEND_IP = "192.168.1.100" // Change to your desktop IP
    static let BACKEND_PORT = 8000
    static let SIGNALING_PORT = 8001
    
    // WebSocket URLs
    static let NOTIFICATION_URL = "ws://\(BACKEND_IP):\(BACKEND_PORT)/ws/notifications"
    static let WEBRTC_SIGNALING_URL = "ws://\(BACKEND_IP):\(SIGNALING_PORT)/ws/webrtc/user_ios"
    
    // REST API base
    static let API_BASE_URL = "http://\(BACKEND_IP):\(BACKEND_PORT)"
    
    // STUN/TURN servers
    static let STUN_SERVERS = [
        "stun:stun.l.google.com:19302",
        "stun:stun1.l.google.com:19302",
        "stun:stun2.l.google.com:19302",
        "stun:stun3.l.google.com:19302"
    ]
    
    // Self-hosted TURN (optional)
    static let TURN_SERVER = "turn:\(BACKEND_IP):3478"
    static let TURN_USERNAME = "alos"
    static let TURN_PASSWORD = "alos_free_password"
}
//
//
//  Extensions.swift
//  ALOS
//

import SwiftUI

// MARK: - Color Extensions
extension Color {
    static let alosBlue = Color.blue
    static let alosGreen = Color.green
    static let alosRed = Color.red
    static let alosGray = Color.gray
    
    static func agentColor(for agent: Agent) -> Color {
        switch agent {
        case .friday: return .blue
        case .jarvis: return .purple
        case .atlas: return .orange
        case .nova: return .pink
        }
    }
}

// MARK: - Date Extensions
extension Date {
    func timeAgoString() -> String {
        let interval = Date().timeIntervalSince(self)
        
        if interval < 60 {
            return "Just now"
        } else if interval < 3600 {
            let minutes = Int(interval / 60)
            return "\(minutes)m ago"
        } else if interval < 86400 {
            let hours = Int(interval / 3600)
            return "\(hours)h ago"
        } else {
            let days = Int(interval / 86400)
            return "\(days)d ago"
        }
    }
}

// MARK: - String Extensions
extension String {
    var capitalizedFirst: String {
        return prefix(1).uppercased() + dropFirst()
    }
}
//
//
//  NetworkMonitor.swift
//  ALOS
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected = true
    @Published var connectionType: NWInterface.InterfaceType?
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                self?.connectionType = path.availableInterfaces.first?.type
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
