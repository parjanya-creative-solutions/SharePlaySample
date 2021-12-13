//
//  CoordinationManager.swift
//  SharePlay-Demo
//
//  Created by Kanishka on 13/12/21.
//

import Foundation
import Combine
import GroupActivities

class CoordinationManager {
    
    static let shared = CoordinationManager()
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var currentSession : Video?
    @Published var groupSession : GroupSession<VideoSharingActivity>?
    
    private init() {
        Task {
            for await groupSession in VideoSharingActivity.sessions() {
                self.groupSession = groupSession
                subscriptions.removeAll()
                
                groupSession.$state.sink { [weak self] state in
                    if case .invalidated = state {
                        self?.groupSession = nil
                        self?.subscriptions.removeAll()
                    }
                }.store(in: &subscriptions)
                
                groupSession.join()
                
                groupSession.$activity.sink { [weak self] activity in
                    self?.currentSession = activity.video
                    print("🔄 Sinking \(activity.video)")
                }.store(in: &subscriptions)
            }
        }
    }
    
    func prepareToPlay(_ selectedSession : Video) {
        
        guard currentSession != selectedSession else { return }
        
        if let groupSession = groupSession {
            groupSession.activity = VideoSharingActivity(video: selectedSession)
        } else {
            Task.init {
                let activity = VideoSharingActivity(video: selectedSession)
                
                switch await activity.prepareForActivation() {
                case .activationDisabled:
                    self.currentSession = selectedSession
                    print("Playing the session locally")
                case .activationPreferred:
                        try await activity.activate()
                    print("Activating the session")
                case .cancelled :
                    print("Session cancelled")
                    break
                default: ()
                }
            }
        }
    }
}
