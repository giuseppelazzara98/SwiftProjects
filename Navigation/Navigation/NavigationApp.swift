//
//  NavigationApp.swift
//  Navigation
//
//  Created by Giuseppe Lazzara on 17/06/24.
//

import SwiftUI

@main
struct NavigationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(PathStore())
        }
    }
}
