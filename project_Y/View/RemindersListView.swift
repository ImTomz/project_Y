//
//  NewReminderView.swift
//  project_Y
//
//  Created by Tomas Boda on 27/12/2021.
//

import SwiftUI

struct RemindersListView: View {
    var body: some View {
        ZStack {
            NavigationLink(destination: ClassicReminderView()) {
                Text("Classic")
            }
        }
        .toolbar
        {
            ToolbarItem(placement: .navigationBarTrailing) {
                VStack(alignment:.trailing) {
                    Text("Create New Reminder").font(.headline)
                    Text("Choose from types below").font(.subheadline)
                }
            }
        }
    }
}


struct ReminderList_Previews: PreviewProvider {
    static var previews: some View {
        RemindersListView()
    }
}
