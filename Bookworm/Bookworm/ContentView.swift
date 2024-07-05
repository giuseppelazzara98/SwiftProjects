import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingAddScreen = false
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Book.title), SortDescriptor(\Book.author)]) var books: [Book]
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating > 1 ? .black : .red)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
            .navigationDestination(for: Book.self){ book in
                DetailView (book: book)
            }
            
            
        }
    }
    
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets {
            // find this book in our query
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
