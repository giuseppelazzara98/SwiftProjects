import SwiftUI

struct ListRowView: View {
    var item: ExpenseItem
    var body: some View {
        HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.type)
                }

                Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                .foregroundStyle(expenseStyle(price: item.amount))
            }
    }
    
    func expenseStyle(price: Double) -> Color{
        switch price {
        case 0...10:
            return .green
        case 11...100:
            return .orange
        case 101...:
            return .red
        default:
            return .primary
        }
    }
}

#Preview {
    ListRowView(item: ExpenseItem(name: "Groceries", type: "Personal", amount: 20.0))
}
