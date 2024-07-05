import SwiftUI

struct MissionGridLabel: View {
    var mission: Mission
    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(.lightBackground)
            .frame(maxWidth: .infinity)
            
        }.clipShape(.rect(cornerRadius: 10))
            .clipShape(.rect(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            )
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    return MissionGridLabel(mission: missions[0])
}
