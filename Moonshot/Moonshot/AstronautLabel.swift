import SwiftUI

struct AstronautLabel: View {
    let crewMember: CrewMember
    var body: some View {
        HStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(.capsule)
                .overlay(
                    Capsule()
                        .strokeBorder(.white, lineWidth: 1)
                )

            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .foregroundStyle(.white)
                    .font(.headline)
                Text(crewMember.role)
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
    }
}

#Preview {
    AstronautLabel(crewMember: CrewMember(role: "Captain", astronaut: Astronaut(id: "haise", name: "Roger", description: "Description"))).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
