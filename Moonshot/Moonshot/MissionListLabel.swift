import SwiftUI

struct MissionListLabel: View {
    var mission: Mission
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding()
            
            VStack(alignment: .leading){
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.trailing, 150)
            
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
    return MissionListLabel(mission: missions[0])
}

