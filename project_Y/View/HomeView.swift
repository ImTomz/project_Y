//
//  ContentView.swift
//  project_Y
//
//  Created by Tomas Boda on 27/12/2021.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    
    // Creating global object across evert view for helping with notification creation
    @StateObject var notificationsHelper = NotificationsHelper()
    
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
            notificationsHelper.requestPermisionForNotification()
        }.environmentObject(notificationsHelper) // Passing global object to navigation view
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
