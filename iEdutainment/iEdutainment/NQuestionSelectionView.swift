import SwiftUI

struct NQuestionSelectionView: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        VStack(alignment: .leading){
            Text("Select the number of questions")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            
            Stepper {
                Text("Number: \(modelData.numberQuestion)").font(.title3)
            } onIncrement:{
                incrementStep()
            }
        onDecrement: {
            decrementStep()
        }
            
            
        }
        
    }
    func incrementStep(){
        switch modelData.numberQuestion {
        case 5:
            modelData.numberQuestion += 5
        case 10:
            modelData.numberQuestion += 10
        case 20:
            modelData.numberQuestion += 0
        default:
            modelData.numberQuestion += 0
        }
        
    }
    
    func decrementStep(){
        switch modelData.numberQuestion {
        case 5:
            modelData.numberQuestion -= 0
        case 10:
            modelData.numberQuestion -= 5
        case 20:
            modelData.numberQuestion -= 10
        default:
            modelData.numberQuestion -= 0
        }
    }
    
    
}


#Preview {
    NQuestionSelectionView().environmentObject(ModelData())
}

