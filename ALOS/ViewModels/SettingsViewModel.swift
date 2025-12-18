//
//  SettingsViewModel.swift
//  ALOS
//

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    @Published var backendURL: String
    @Published var voiceFeedbackEnabled: Bool
    @Published var autoAnswerCalls: Bool
    @Published var notificationsEnabled: Bool
    
    init() {
        // Load from UserDefaults
        backendURL = UserDefaults.standard.string(forKey: "backendURL")
            ?? ALOSConfig.API_BASE_URL
        voiceFeedbackEnabled = UserDefaults.standard.bool(forKey: "voiceFeedback")
        autoAnswerCalls      = UserDefaults.standard.bool(forKey: "autoAnswer")
        notificationsEnabled = UserDefaults.standard.bool(forKey: "notifications")
    }
    
    func saveSettings() {
        UserDefaults.standard.set(backendURL, forKey: "backendURL")
        UserDefaults.standard.set(voiceFeedbackEnabled, forKey: "voiceFeedback")
        UserDefaults.standard.set(autoAnswerCalls, forKey: "autoAnswer")
        UserDefaults.standard.set(notificationsEnabled, forKey: "notifications")
    }
    
    func testConnection() {
        guard let url = URL(string: "\(backendURL)/health") else { return }
        
        URLSession.shared.dataTask(with: url) { _, _, error in
            DispatchQueue.main.async {
                if error == nil {
                    print("✅ Connection successful")
                } else {
                    print("❌ Connection failed: \(error?.localizedDescription ?? "")")
                }
            }
        }.resume()
    }
}
