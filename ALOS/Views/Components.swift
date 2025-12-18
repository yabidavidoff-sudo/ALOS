//
//  Components.swift
//  ALOS - Reusable UI components
//

import SwiftUI

struct StatusCard: View {
    let title: String
    let status: String
    let color: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(status)
                    .font(.title2)
                    .bold()
            }
            Spacer()
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(color)
                    .clipShape(Circle())
                
                Text(title)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct NotificationRow: View {
    let notification: AgentNotification
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: agentIcon)
                .foregroundColor(agentColor)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.agent.capitalized)
                    .font(.headline)
                Text(notification.message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Text(notification.timestamp.timeAgoString())
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
    
    private var agentIcon: String {
        switch notification.agent.lowercased() {
        case "friday": return "phone.circle.fill"
        case "jarvis": return "person.circle.fill"
        case "atlas": return "map.circle.fill"
        case "nova": return "star.circle.fill"
        default: return "bell.circle.fill"
        }
    }
    
    private var agentColor: Color {
        switch notification.agent.lowercased() {
        case "friday": return .blue
        case "jarvis": return .purple
        case "atlas": return .orange
        case "nova": return .pink
        default: return .gray
        }
    }
}
