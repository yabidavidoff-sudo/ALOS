//
//  Agent.swift
//  ALOS
//

import Foundation

enum Agent: String, CaseIterable, Codable {
    case friday
    case jarvis
    case atlas
    case nova
    
    var voiceIdentifier: String {
        switch self {
        case .friday:
            return "com.apple.ttsbundle.Samantha-compact"
        case .jarvis:
            return "com.apple.ttsbundle.Daniel-compact"
        case .atlas:
            return "com.apple.ttsbundle.Alex-compact"
        case .nova:
            return "com.apple.ttsbundle.Karen-compact"
        }
    }
    
    var speechRate: Float {
        switch self {
        case .friday: return 0.52
        case .jarvis: return 0.48
        case .atlas: return 0.50
        case .nova: return 0.54
        }
    }
}
