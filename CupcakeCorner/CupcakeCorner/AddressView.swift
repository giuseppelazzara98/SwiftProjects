import SwiftUI

struct AddressView: View {
    @EnvironmentObject var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.userDetails.name)
                TextField("Street Address", text: $order.userDetails.streetAddress)
                TextField("City", text: $order.userDetails.city)
                TextField("Zip", text: $order.userDetails.zip)
            }
            Section{
                NavigationLink("Checkout"){
                    CheckoutView()
                }
            }
            .disabled(!order.userDetails.hasValidAddress)
            
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView().environmentObject(Order())
}
