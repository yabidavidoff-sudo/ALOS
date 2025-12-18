class CallViewModel: ObservableObject {
    @Published var selectedAgent: Agent = .friday
    @Published var isInCall: Bool = false
    @Published var callDuration: TimeInterval = 0

    private var callTimer: Timer?
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscriptions()
    }

    private func setupSubscriptions() {
        CallKitManager.shared.$isCallActive
            .sink { [weak self] isActive in
                self?.isInCall = isActive
                if isActive {
                    self?.startCallTimer()
                } else {
                    self?.stopCallTimer()
                }
            }
            .store(in: &cancellables)
    }

    func startCall() {
        CallKitManager.shared.startCall(to: selectedAgent)
    }

    func endCall() {
        CallKitManager.shared.endCall()
    }

    private func startCallTimer() {
        callDuration = 0
        callTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.callDuration += 1
        }
    }

    private func stopCallTimer() {
        callTimer?.invalidate()
        callTimer = nil
    }
}
