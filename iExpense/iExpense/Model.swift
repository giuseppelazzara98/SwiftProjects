import Foundation

class Model : ObservableObject {
    @Published var items = [ExpenseItem] () {
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personalItems: [ExpenseItem] { items.filter {$0.type == "Personal"}}
    var businessItems: [ExpenseItem] { items.filter {$0.type == "Business"}}
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
        
    }
    
    
}
