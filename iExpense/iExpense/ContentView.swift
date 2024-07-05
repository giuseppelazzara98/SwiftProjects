import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: Model
    @State private var showingAddExpense = false
    @State private var path: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Text("Business Expenses")
                    .font(.title2)
                    .bold()
                ForEach(modelData.businessItems) { item in
                    ListRowView(item: item)
                }
                .onDelete(perform: removeItems)
            }.navigationTitle("iExpense")
                .toolbar {
                    //showingAddExpense.toggle()
                    NavigationLink{
                        AddView()
                    }
                label:{
                    Label("Add", systemImage: "plus")
                }
                
                    
                }
            List {
                Text("Personal Expenses")
                    .font(.title2)
                    .bold()
                ForEach(modelData.personalItems) { item in
                    ListRowView(item: item)
                }
                .onDelete(perform: removeItems)
                
            }
        }/*.sheet(isPresented: $showingAddExpense) {
          AddView(isDone: $showingAddExpense)
          
          }*/
    }
    
    func removeItems(at offsets: IndexSet){
        modelData.items.remove(atOffsets: offsets)
    }
    
}


#Preview {
    ContentView().environmentObject(Model())
}
