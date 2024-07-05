import SwiftUI

struct ListLayout: View {
    var missions : [Mission]
    var astronauts: [String: Astronaut]
    var body: some View {
            LazyVStack {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        MissionListLabel(mission: mission)
                    }
                }
            }
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    return ListLayout(missions: missions, astronauts: astronauts)
}

