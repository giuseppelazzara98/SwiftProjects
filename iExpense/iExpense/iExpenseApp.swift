//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Giuseppe Lazzara on 04/06/24.
//

import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Model())
        }
    }
}
