//
//  ContentView.swift
//  project_Y
//
//  Created by Tomas Boda on 27/12/2021.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
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
            requestPermisionForNotification()
        }
    }
    
    func requestPermisionForNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            
            if let error = error {
                // Handle the error here.
                print(error)
            }
            
            // Enable or disable features based on the authorization.
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
