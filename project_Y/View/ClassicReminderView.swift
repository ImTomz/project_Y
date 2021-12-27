//
//  ClassicReminderView.swift
//  project_Y
//
//  Created by Tomas Boda on 28/12/2021.
//

import SwiftUI
import UIKit
import UserNotifications

struct ClassicReminderView: View {
    
    @State var label = ""
    @State var pickedDate = Date()
    
    private let daysInWeek = ["S","M","T","W","T","F","S"]
    
    @State private var activeDays: [Int] = []
    
    var body: some View {
        Background {
            VStack {
                
                // ------Debug purpose -start
                ForEach(activeDays, id: \.self) { activeday in
                    Text("\(activeday)")
                }
                // ------Debug purpose -end
                
                TextField("Label", text: $label)
                    .border(.secondary)
                DatePicker("", selection: $pickedDate, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                Button("Confirm") {
                    self.createReminder();
                }
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach(Array(daysInWeek.enumerated()), id: \.offset) { index, day in
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
        Color.white
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
