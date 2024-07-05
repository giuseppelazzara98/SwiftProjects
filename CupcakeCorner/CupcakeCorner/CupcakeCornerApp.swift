//
//  CupcakeCornerApp.swift
//  CupcakeCorner
//
//  Created by Giuseppe Lazzara on 18/06/24.
//

import SwiftUI

@main
struct CupcakeCornerApp: App {
    @StateObject private var order = Order()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(order)
        }
    }
}
