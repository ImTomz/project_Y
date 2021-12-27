//
//  project_YApp.swift
//  project_Y WatchKit Extension
//
//  Created by Tomas Boda on 27/12/2021.
//

import SwiftUI

@main
struct project_YApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
