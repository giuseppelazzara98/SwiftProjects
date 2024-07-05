import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var showingErrorAlert = false
    @State private var alertErrorMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "EUR"))")
                            .font(.title)
                
                Button("Place Order"){
                    Task {
                        await placeOrder()
                    }
                }
                            .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingAlert){
            Button("Ok"){}
        }message: {
            Text(alertMessage)
        }
        .alert("Error", isPresented: $showingErrorAlert){
            Button("Ok"){
            }
        }message: {
            Text(alertErrorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let(data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingAlert = true
        }
        catch {
            print("Checkout failed: \(error.localizedDescription)")
            showingErrorAlert = true
            alertErrorMessage = "Something went wrong"
        }
        
    }
}



#Preview {
    CheckoutView().environmentObject(Order())
}
