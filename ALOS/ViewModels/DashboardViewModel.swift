//
//  DashboardViewModel.swift
//  ALOS
//

import Foundation
import Combine

class DashboardViewModel: ObservableObject {
    @Published var isLoading = false
    
    func refresh() {
        isLoading = true
        // TODO: Implement refresh logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
        }
    }
}
