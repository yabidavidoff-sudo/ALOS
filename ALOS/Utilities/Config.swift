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

