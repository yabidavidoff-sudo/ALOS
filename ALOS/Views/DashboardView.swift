import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var webSocketManager: WebSocketManager
    @EnvironmentObject var voiceManager: VoiceManager
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Header
                    WelcomeCard()
                    
                    // System Status with Better Visual
                    SystemStatusCard(isConnected: webSocketManager.isConnected)
                    
                    // Quick Actions Grid (4 buttons)
                    QuickActionsGrid()
                    
                    // Active Tasks Widget
                    ActiveTasksWidget()
                    
                    // Recent Notifications
                    NotificationsSection(
                        notifications: Array(webSocketManager.notifications.prefix(5))
                    )
                }
                .padding()
            }
            .navigationTitle("ALOS")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.refresh() }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}

struct WelcomeCard: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back!")
                    .font(.title2)
                    .bold()
                Text(greetingTime)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "hand.wave.fill")
                .font(.system(size: 40))
                .foregroundColor(.yellow)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [.blue.opacity(0.1), .purple.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
    
    private var greetingTime: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }
}

struct SystemStatusCard: View {
    let isConnected: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(isConnected ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: isConnected ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(isConnected ? .green : .red)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(isConnected ? "System Online" : "System Offline")
                    .font(.headline)
                Text(isConnected ? "All agents ready" : "Reconnecting...")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if isConnected {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .foregroundColor(.green)
                    .symbolEffect(.variableColor.iterative.reversing)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct QuickActionsGrid: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)
            
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 12
            ) {
                QuickActionButton(
                    icon: "mic.fill",
                    title: "Voice Command",
                    color: .blue,
                    action: { VoiceCommandManager.shared.startListening() }
                )
                
                QuickActionButton(
                    icon: "phone.fill",
                    title: "Call Friday",
                    color: .green,
                    action: { CallKitManager.shared.startCall(to: .friday) }
                )
                
                QuickActionButton(
                    icon: "person.fill",
                    title: "Call Jarvis",
                    color: .purple,
                    action: { CallKitManager.shared.startCall(to: .jarvis) }
                )
                
                QuickActionButton(
                    icon: "chart.bar.fill",
                    title: "View Stats",
                    color: .orange,
                    action: { /* Navigate to stats */ }
                )
            }
        }
    }
}

struct ActiveTasksWidget: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Active Tasks")
                    .font(.headline)
                Spacer()
                Text("3")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
            
            VStack(spacing: 8) {
                TaskRow(title: "Process emails", agent: "Friday", progress: 0.7)
                TaskRow(title: "Research report", agent: "Atlas", progress: 0.4)
                TaskRow(title: "Schedule meetings", agent: "Jarvis", progress: 0.9)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct TaskRow: View {
    let title: String
    let agent: String
    let progress: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.subheadline)
                Spacer()
                Text(agent)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            ProgressView(value: progress)
                .tint(.blue)
        }
        .padding(8)
        .background(Color.white.opacity(0.5))
        .cornerRadius(8)
    }
}

struct NotificationsSection: View {
    let notifications: [AgentNotification]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recent Activity")
                    .font(.headline)
                Spacer()
                Button("See All") {
                    // Navigate to full list
                }
                .font(.caption)
            }
            
            if notifications.isEmpty {
                EmptyStateView()
            } else {
                ForEach(notifications, id: \.timestamp) { notification in
                    NotificationRow(notification: notification)
                }
            }
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .font(.system(size: 40))
                .foregroundColor(.secondary)
            Text("No recent activity")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(40)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
