import SwiftUI
import Combine

struct QuestionView: View {
    @State private var answer : String = ""
    @State private var buttonColor: Color = .green
    @State private var buttonText = "Submit"
    @State private var animationAmount: CGFloat = 1.0
    @EnvironmentObject var modelData: ModelData
    var question: Question
    
    var body: some View {
        
        VStack{
            HStack(){
                VStack(alignment: .leading){
                    Text("\(question.operands.0) X \(question.operands.1) =").font(.title2)
                    TextField("Enter the answer", text: $answer)
                        .keyboardType(.numberPad)
                    
                    
                }
                Button(action: {
                    
                    
                    if let answerInt = Int(answer), answerInt == question.operands.0 * question.operands.1 {
                        withAnimation {
                            modelData.removeQuestion(byId: question.id)
                        }
                        modelData.correctQuestions += 1
                        
                        
                    }
                    else {
                        withAnimation(.bouncy){
                            buttonColor = .red
                            buttonText = "Wrong"
                            animationAmount = 1.1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.default) {
                                animationAmount = 1.0
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                buttonColor = .green
                                buttonText = "Submit"
                            }
                        }
                                            }
                }, label: {
                    Text(buttonText)
                        .foregroundStyle(.black)
                        .padding(.maximum(10, 10))
                        .background(buttonColor)
                        .cornerRadius(16)
                        .scaleEffect(animationAmount)
                }).padding(.top)
                    
            }
            .padding()
        }
    }
}

#Preview {
    QuestionView(question:Question(operands: (2, 2))).environmentObject(ModelData())
}
