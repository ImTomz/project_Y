//
//  CreateReminder.swift
//  project_Y
//
//  Created by Tomas Boda on 30/12/2021.
//

import UserNotifications
import SwiftUI


class NotificationsHelper: ObservableObject {
    
    let daysInWeek = ["S","M","T","W","T","F","S"]
    
    // Request permision for notification from user.
    func requestPermisionForNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            
            if let error = error {
                // Handle the error here.
                print(error)
            }
            
            if (!granted) {
                print("Permision denied!")
            }
            // Enable or disable features based on the authorization.
        }
    }
    
    // Schedule Notification with weekly bases.
    func scheduleNotification(at date: Date, body: String, titles:String) {

        let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)

        let content = UNMutableNotificationContent()
        content.title = titles
        content.body = body
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "reminder"

        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }

    // Create Date from picker selected value.
    func createDate(weekday: Int, hour: Int, minute: Int)->Date{

           var components = DateComponents()
           components.hour = hour
           components.minute = minute
           components.weekday = weekday // sunday = 1 ... saturday = 7
           components.weekdayOrdinal = 10
           components.timeZone = .current

           let calendar = Calendar(identifier: .gregorian)
           return calendar.date(from: components)!
    }

    // Formate time into string from Date.
    func formatTime(date: Date)-> String {
        var timeFormatter : DateFormatter {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.locale = Locale(identifier: "en_GB") // your locale here
            return formatter
        }
        
        let formatedTime = timeFormatter.string(from: date)
        return formatedTime
    }
    
    // TODO: Check for notifications permission
    func checkNotificationsPermission() {
        
    }
}


