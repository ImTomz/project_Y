//
//  Reminder_Classic_ViewModel.swift
//  project_Y
//
//  Created by Tomas Boda on 27/12/2021.
//

import Foundation

class ClassicViewModel {
    
    var label: String;
    var identifier: UUID;
    
    init(label:String,identifier: UUID) {
        self.label = label;
        self.identifier = identifier;
    }
    
    init(classic_reminder: Reminder_Classic) {
        self.label = classic_reminder.label;
        self.identifier = classic_reminder.identifier;
    }
}
