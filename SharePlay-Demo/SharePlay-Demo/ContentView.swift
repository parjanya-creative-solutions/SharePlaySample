//
//  ContentView.swift
//  SharePlay-Demo
//
//  Created by Kanishka on 13/12/21.
//

import SwiftUI
import GroupActivities

struct ContentView: View {
    var body: some View {
        TabView {
      FirstTab()
            .tabItem {
            Label("Tab 1", systemImage: "1.circle.fill")
            }
            
            Color.white
                .tabItem {
                    Label("Tab", systemImage: "2.circle.fill")
                }
                
        }.accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
