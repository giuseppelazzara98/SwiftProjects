import SwiftUI

struct ContentView: View {
    let astronauts : [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions : [Mission] = Bundle.main.decode("missions.json")
    
    
    @State private var showingGrid = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if showingGrid {
                        GridLayout(missions: missions, astronauts: astronauts)
                    } else {
                        ListLayout(missions: missions, astronauts: astronauts)
                    }
                }
                .navigationTitle("Moonshot")
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .toolbar {
                    Toggle(isOn: $showingGrid, label: {
                        Text(showingGrid ? "Grid" : "List")
                            .foregroundStyle(.blue)
                    })
                    .toggleStyle(.switch)
                    .tint(.blue)
                }
                
            }
            .background(.darkBackground)
        }
        
        
        
        
        
        
        
    }
    
}

#Preview {
    ContentView()
}
