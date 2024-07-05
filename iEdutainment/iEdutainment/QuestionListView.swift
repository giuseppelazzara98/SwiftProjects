import SwiftUI

struct QuestionListView: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var navigateBack : Bool
    var body: some View {
        NavigationSplitView{
            List{
                ForEach(Array(modelData.generatedQuestions)){  question in
                    QuestionView(question: question)
                    
                }
                
            }
            .navigationTitle("Table of \(modelData.multiplicationTable)")
            if (modelData.generatedQuestions.isEmpty){
                VStack{
                    Spacer()
                    Text ("Correct answer: \(modelData.correctQuestions)")
                    Button("Restart Game"){
                        navigateBack = false
                    }
                    Spacer()}
            }
        } detail: {
            Text("")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
/*
#Preview {
    
    QuestionListView( ).environmentObject(ModelData())
}
*/
