import SwiftUI

struct AddView: View {
    @State private var name = "New Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    //@Binding var isDone: Bool
    @EnvironmentObject var modelData: Model
    @Environment(\.presentationMode) var presentationMode
    
    let types = ["Business", "Personal"]
    var body: some View {
        NavigationStack {
            Form {
                //TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField ("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    .keyboardType(.decimalPad)
            }
            .toolbar{
                Button("Save") {
                    addItem()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)

        }
    }
    func addItem () {
        modelData.items.append(ExpenseItem(name: name, type: type, amount: amount))
    }
}
/*
#Preview {
    AddView().environmentObject(Model())
}
*/
