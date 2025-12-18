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
        prefix(1).uppercased() + dropFirst()
    }
}
