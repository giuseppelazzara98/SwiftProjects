//
//  ContentView.swift
//  Navigation
//
//  Created by Giuseppe Lazzara on 17/06/24.
//

import SwiftUI

struct DetailView: View {
    var number: Int
    @Binding var path: NavigationPath
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
        Button("Home"){
            path = NavigationPath()
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var pathStore: PathStore
    @State private var title = "SwiftUI"
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            Text("Hello")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction){
                        Button("Button"){
                            // button action here
                        }
                    }
                }
                .navigationTitle($title)
                    .navigationBarTitleDisplayMode(.inline)
            
            
            DetailView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $pathStore.path)
                }
        }
    }
}

#Preview {
    ContentView().environmentObject(PathStore())
}
