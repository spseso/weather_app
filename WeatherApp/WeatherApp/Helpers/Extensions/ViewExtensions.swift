//
//  ViewExtensions.swift
//  WeatherApp
//
//  Created by Sevak Soghoyan on 5/14/23.
//

import SwiftUI

// This extension provides methods for customizing View
extension View {
    /// Sets the text color for a navigation bar title.
    /// - Parameter color: Color the title should be
    ///
    /// Supports both regular and large titles.
    ///
    /// - Returns: A modified version of the view with the navigation bar title text color set.
    ///
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        
        // Set the appearance for the navigation bar title text color.
        let textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: uiColor]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        
        // Return the modified view.
        return self
    }
    
    /// Hides keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}






