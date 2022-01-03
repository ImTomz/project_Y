//
//  UIApplication_extensions.swift
//  project_Y
//
//  Created by Tomas Boda on 28/12/2021.
//

import UIKit

extension UIApplication {
    
    // Function for hidding keyboard
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
