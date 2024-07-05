import Foundation

struct ExpenseItem: Identifiable, Codable{
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}
