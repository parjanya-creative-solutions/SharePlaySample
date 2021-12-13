//
//  FirstTab.swift
//  SharePlay-Demo
//
//  Created by Kanishka on 13/12/21.
//

import SwiftUI
import GroupActivities

struct FirstTab : View {
    
    @State  var currentSession : GroupSession<VideoSharingActivity>?
    @State var sessionDidLoad = false
    var body : some View {
        NavigationView {
            List {
                ForEach(videos, id: \.self) {item in
                    NavigationLink(destination: VideoPlayerController(url: item.url, ftSession: currentSession).navigationBarHidden(true)){
                    Text(item.title)
                            .simultaneousGesture(TapGesture().onEnded { _ in
                                CoordinationManager.shared.prepareToPlay(item)
                                self.sessionDidLoad = true
                            })
                    }
                }
            }
                .navigationTitle("First Tab")
        }.navigationViewStyle(StackNavigationViewStyle())
        .task {
            Task.init {
                for await session in VideoSharingActivity.sessions() {
                    self.currentSession = session
                    NavigationController.navigationAction { navigationController in
                            var videplayer = VideoPlayerController(url: session.activity.video.url, ftSession: session)
                            var hostingController = UIHostingController(rootView: videplayer)
                        if sessionDidLoad == false {
                            navigationController.pushViewController(hostingController, animated: false)
                        }
                    }
                }
            }
        }
    }
}
