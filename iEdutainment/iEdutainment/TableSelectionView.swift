import SwiftUI

struct TableSelectionView: View {
    
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        VStack(alignment: .leading){
            Text("Select the multiplication table you want to practice")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Stepper(value: $modelData.multiplicationTable, in: 2...12, step: 1){
                Text("Table of: \(modelData.multiplicationTable)").font(.title3)
                
            }
        }
    }
}

#Preview {
    TableSelectionView().environmentObject(ModelData())
}
