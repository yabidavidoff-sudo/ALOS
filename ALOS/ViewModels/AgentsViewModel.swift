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
