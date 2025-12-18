//
//  AgentNotification.swift
//  ALOS
//
//  Created by yabi davidoff on 2025-12-17.
//


//
//  AgentNotification.swift
//  ALOS
//

import Foundation

struct AgentNotification: Codable {
    let agent: String
    let message: String
    let priority: Bool
    let timestamp: Date
    let notificationType: NotificationType
    
    enum NotificationType: String, Codable {
        case voice
        case alert
        case approval
    }
}
