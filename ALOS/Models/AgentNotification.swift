//
//  AgentNotification.swift
//  ALOS
//

import Foundation

struct AgentNotification: Identifiable {
    let id = UUID()
    let timestamp: Date
    let agent: Agent
    let message: String
    let priority: Int
    
    init(timestamp: Date = Date(), agent: Agent = .friday, message: String, priority: Int = 0) {
        self.timestamp = timestamp
        self.agent = agent
        self.message = message
        self.priority = priority
    }
}
