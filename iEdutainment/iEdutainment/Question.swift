import Foundation

struct Question: Identifiable {
    var id: UUID = UUID()
    var operands: (Int,Int)
}
