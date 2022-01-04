//
//  ContentView.swift
//  project_Y
//
//  Created by Tomas Boda on 27/12/2021.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    
    // Creating global object across every view for helping with notification
    @StateObject var notificationsManager = NotificationsManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                Text("Home view")
            }
            .toolbar
            {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: RemindersListView()) {
                        Text("Menu")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    VStack(alignment:.trailing) {
                        Text("Wednesday, 28 March").font(.headline)
                        Text("2:48 AM").font(.subheadline)
                    }
                }
            }
        }.onAppear {
            notificationsManager.requestAuthorization { granted in } // Request init authorization for notifications
        }.environmentObject(notificationsManager) // Passing notifications manager to navigation view
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
