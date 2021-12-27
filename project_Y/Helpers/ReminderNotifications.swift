//
//  CreateReminder.swift
//  project_Y
//
//  Created by Tomas Boda on 30/12/2021.
//

import Foundation
import UserNotifications


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
