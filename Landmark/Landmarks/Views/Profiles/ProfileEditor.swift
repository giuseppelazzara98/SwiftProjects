/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An editable profile view.
*/

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode

    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }

    var body: some View {
        /*HStack{
            Spacer()
            Button("Save"){
                modelData.profile = profile
                presentationMode.wrappedValue.dismiss()
            }.padding(.trailing)
            
        }*/
        NavigationStack {
        List {
            HStack {
                Text("Username")
                Spacer()
                TextField("Username", text: $profile.username)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications")
            }
            
            Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
                ForEach(Profile.Season.allCases) { season in
                    Text(season.rawValue).tag(season)
                }
            }
            
            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date) {
                Text("Goal Date")
            }
        }
    }.toolbar {
        ToolbarItem(placement: .confirmationAction) {
            Button("Save") {
                modelData.profile = profile
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
        
    }
}

#Preview {
    ProfileEditor(profile: .constant(.default))
}
