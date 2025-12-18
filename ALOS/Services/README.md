# ALOS Services

All service managers for the iOS app:

- `VoiceManager.swift` – Text-to-speech for agents
- `WebSocketManager.swift` – Real-time backend notifications
- `VoiceCommandManager.swift` – Speech recognition
- `WebRTCManager.swift` – Peer-to-peer voice calls
- `CallKitManager.swift` – Native iOS calling integration
- `PushKitManager.swift` – VoIP push notifications

All services use the singleton pattern via `.shared`.

