/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileHost: View {
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    @State private var isEditing = false

    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    EditButton{
                        draftProfile = modelData.profile
                        isEditing = true
                    }
                }
                
                
                ProfileSummary(profile: modelData.profile)
            }
            .padding()
            .navigationDestination(isPresented: $isEditing){
                ProfileEditor(profile: $draftProfile)
            }
        }
    }
}

struct EditButton: View{
    var action: () -> Void
    
    var body: some View{
        Button("Edit", action: action)
    }
    
    
}

#Preview {
    ProfileHost()
        .environmentObject(ModelData())
}
