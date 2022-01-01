//
//  ClassicReminderView.swift
//  project_Y
//
//  Created by Tomas Boda on 28/12/2021.
//

import SwiftUI
import UIKit

struct ClassicReminderView: View {
    
    @EnvironmentObject var notificationsHelper: NotificationsHelper
    
    @State var label = ""
    @State var pickedDate = Date()
    @State var timeString = ""
    @State private var activeDays: [Int] = []
    
    var body: some View {
        Background {
            VStack {
                
                TextField("Label", text: $label)
                    .border(.secondary)
                DatePicker("", selection: $pickedDate, displayedComponents: .hourAndMinute)
                    .onChange(of: pickedDate, perform: { value in
                        timeString = notificationsHelper.formatTime(date: pickedDate)
                                })
                    .labelsHidden()
                Button("Confirm") {
                    self.createReminder();
                }
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach(Array(notificationsHelper.daysInWeek.enumerated()), id: \.offset) { index, day in
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
            }
        }
        .onAppear(perform: {
            timeString = notificationsHelper.formatTime(date: Date())
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Confirm") {
                    self.createReminder();
                }
            }
        }
        .onTapGesture {
            self.endEditing()
        }
    }
    
    // Final function for creating reminder
    private func createReminder() {
        
            print("\(label)")
            print("\(timeString)")
            print("\(activeDays)")
        
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
