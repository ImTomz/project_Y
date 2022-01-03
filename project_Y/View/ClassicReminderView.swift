//
//  ClassicReminderView.swift
//  project_Y
//
//  Created by Tomas Boda on 28/12/2021.
//

import SwiftUI
import UIKit
import UserNotifications

enum ActiveAlert {
    case denied,succes
}

struct ClassicReminderView: View {
    
    @EnvironmentObject var notificationsManager: NotificationsManager
    
    @State var label = ""
    @State var pickedDate = Date()
    @State var timeString = ""
    @State private var activeDays: [Int] = []
    @State private var showConfirmAlert = false
    @State private var activeAlert: ActiveAlert = .denied
    
    var body: some View {
        Background {
            VStack {
                TextField("Label", text: $label)
                    .border(.secondary)
                DatePicker("", selection: $pickedDate, displayedComponents: .hourAndMinute)
                    .onChange(of: pickedDate, perform: { value in
                        timeString = notificationsManager.formatTime(date: pickedDate)
                                })
                    .labelsHidden()
                LazyHGrid(rows: Array(repeating: .init(.fixed(20)), count: 2)) {
                    ForEach(Array(notificationsManager.daysInWeek.enumerated()), id: \.offset) { index, day in
                        Button("\(day)") {
                            if(!self.activeDays.contains(index + 1)) {
                                self.activeDays.append(index + 1)
                            }else {
                                if let index = self.activeDays.firstIndex(of: index + 1) {
                                    self.activeDays.remove(at: index)
                                }
                            }
                        }.padding(30)
                    }
                }
                Button("Confirm") { self.handleConfirmation() }
            }
        }
        .onAppear(perform: { timeString = notificationsManager.formatTime(date: Date()) })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Confirm") { self.handleConfirmation() }
            }
        }
        .onTapGesture { self.endEditing() } // Calling function for hiding keyboard
        .alert(isPresented: $showConfirmAlert) { // Alerts
            switch activeAlert {
                case .denied:
                    return Alert(title: Text("Enable Notifications?"), message: Text("To use this feature you must enable notifications in settings"), primaryButton: .default(Text("Settings")) {
                        notificationsManager.goToSettings()
                    }, secondaryButton: .cancel())
                case .succes:
                    return Alert(title: Text("Reminder was created!"), message: Text("Your reminder was successfully created"), dismissButton: .default(Text("Got it!")))
            }
        }
    }
    
    // Final function for handling confirm pressed
    private func handleConfirmation() {
        // Calling notifications settings for changing state of notifications authorization without refreshing
        UNUserNotificationCenter.current().getNotificationSettings { settings in
          DispatchQueue.main.async {
              if(settings.authorizationStatus == .authorized) { // Notifications approved
                  // Creating reminder
                  self.createReminder()
                  // Showing alert for successly created reminder
                  self.activeAlert = .succes
                  self.showConfirmAlert = true
                  
              }else {                                           // Notifications denied
                  // Showing alert for permission denied
                  self.activeAlert = .denied
                  self.showConfirmAlert = true
              }
           }
        }
    }
    
    // Crete reminder
    private func createReminder() {
        // TODO: Handle creating reminder
    }
    
    // Hide keyboard function
    private func endEditing() {
           UIApplication.shared.endEditing()
    }
}

// MARK: - Backgorund for gesture toggle keyboard
struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.ui.background
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}

// MARK: - Preview
struct ClassicReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicReminderView()
    }
}
