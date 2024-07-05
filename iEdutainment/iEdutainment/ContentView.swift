import SwiftUI

struct ContentView: View {
    @State private var goToQuestionList = false
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        NavigationStack{
        VStack{
            TableSelectionView()
                .padding(.bottom)
                .padding(.top)
            NQuestionSelectionView()
            Spacer()
            Button("Start Game"){
                modelData.initialiseGame()
                goToQuestionList = true
                
            }
            .navigationDestination(isPresented: $goToQuestionList) {
                QuestionListView( navigateBack: $goToQuestionList)
            }
        }
        .padding(.all)
    }
    }
}

#Preview {
    ContentView().environmentObject(ModelData())
}
