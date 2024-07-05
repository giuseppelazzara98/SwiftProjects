import SwiftUI

struct GridLayout: View {
    var missions : [Mission]
    var astronauts: [String: Astronaut]
    let columns = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    MissionGridLabel(mission: mission)
                }
                
            }
        }.padding([.horizontal, .bottom])
            .navigationDestination(for: Mission.self){ mission in
                MissionView(mission: mission, astronauts: astronauts)
                
            }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    return GridLayout(missions: missions, astronauts: astronauts)
}
