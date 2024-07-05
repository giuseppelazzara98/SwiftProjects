import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts:[String: Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            else {
                fatalError("Missing \(member.name)")
            }
            
        }
    }
    var body: some View {
        ScrollView {
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){ width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                Text(mission.badgeLaunchDate)
                    .font(.title2)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautDetail(astronaut: crewMember.astronaut)
                                } label: {
                                    AstronautLabel(crewMember: crewMember)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                }
                .padding(.horizontal)
                
                
                
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts).preferredColorScheme(.dark)
}
