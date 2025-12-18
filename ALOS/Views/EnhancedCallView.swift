//
//  EnhancedCallView.swift
//  ALOS
//
//  Created by yabi davidoff on 2025-12-17.
//

import SwiftUI

struct EnhancedCallView: View {
    // CallKitManager comes from elsewhere; we don't construct it here.
    @EnvironmentObject var callKitManager: CallKitManager
    @StateObject private var viewModel = CallViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
            // Header
            Text("🎙️ Voice Calls")
                .font(.largeTitle)
                .bold()
            
            if callKitManager.isCallActive {
                // Active Call UI
                ActiveCallView(
                    agent: viewModel.selectedAgent,
                    duration: viewModel.callDuration
                )
            } else {
                // Agent Selection
                AgentSelector(selectedAgent: $viewModel.selectedAgent)
                
                // Big Call Button
                CallButton(agent: viewModel.selectedAgent) {
                    viewModel.startCall()
                }
                
                // Recent Calls
                RecentCallsList()
            }
            
            Spacer()
        }
        .padding()
    }
}

struct AgentSelector: View {
    @Binding var selectedAgent: Agent
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Select Agent")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Agent.allCases, id: \.self) { agent in
                        AgentCard(
                            agent: agent,
                            isSelected: selectedAgent == agent
                        ) {
                            selectedAgent = agent
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct AgentCard: View {
    let agent: Agent
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(isSelected ? selectedColor : Color(.systemGray5))
                        .frame(width: 70, height: 70)
                    
                    Image(systemName: agentIcon)
                        .font(.system(size: 30))
                        .foregroundColor(isSelected ? .white : .secondary)
                }
                
                Text(agent.rawValue.capitalized)
                    .font(.caption)
                    .fontWeight(isSelected ? .bold : .regular)
            }
        }
        .buttonStyle(.plain)
    }
    
    private var agentIcon: String {
        switch agent {
        case .friday: return "phone.circle.fill"
        case .jarvis: return "person.circle.fill"
        case .atlas: return "map.circle.fill"
        case .nova: return "star.circle.fill"
        }
    }
    
    // INSERT THIS HERE, still inside AgentCard:
    private var selectedColor: Color {
        Color.agentColor(for: agent)
    }
}



struct CallButton: View {
    let agent: Agent
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "phone.fill")
                Text("Call \(agent.rawValue.capitalized)")
            }
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                LinearGradient(
                    colors: [.green, .green.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .shadow(color: .green.opacity(0.3), radius: 10, y: 5)
        }
    }
}

struct ActiveCallView: View {
    let agent: Agent
    let duration: TimeInterval
    
    var body: some View {
        VStack(spacing: 30) {
            // Agent Avatar
            ZStack {
                    
                Image(systemName: "person.fill")
                    .font(.system(size: 60))
            }
            
            Text(agent.rawValue.capitalized)
                .font(.title)
                .bold()
            
            Text(formatDuration(duration))
                .font(.title2)
                .foregroundColor(.secondary)
                .monospacedDigit()
            
            // Call Controls
            HStack(spacing: 40) {
                CircleButton(icon: "mic.slash.fill", color: .gray) {
                    // Mute
                }
                
                CircleButton(icon: "speaker.wave.3.fill", color: .blue) {
                    // Speaker
                }
                
                CircleButton(icon: "phone.down.fill", color: .red) {
                    CallKitManager.shared.endCall()
                }
            }
        }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct CircleButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(color)
                .clipShape(Circle())
        }
    }
}

struct RecentCallsList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Calls")
                .font(.headline)
            
            VStack(spacing: 8) {
                RecentCallRow(agent: "Friday", time: "2 min ago", duration: "3:24")
                RecentCallRow(agent: "Jarvis", time: "1 hour ago", duration: "1:45")
                RecentCallRow(agent: "Atlas", time: "Yesterday", duration: "5:12")
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct RecentCallRow: View {
    let agent: String
    let time: String
    let duration: String
    
    var body: some View {
        HStack {
            Image(systemName: "phone.arrow.up.right.fill")
                .foregroundColor(.green)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(agent)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(duration)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(8)
        .background(Color.white.opacity(0.5))
        .cornerRadius(8)
    }
}

