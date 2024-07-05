//
//  DetailView.swift
//  Bookworm
//
//  Created by Giuseppe Lazzara on 01/07/24.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    var body: some View {
        ScrollView {
            
            ZStack(alignment: .leading) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)

            Text(book.review)
                .padding()

            
            Text(book.date)
                .padding(.bottom, 5)
                .font(.subheadline)

            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive){
                deleteBook()
            }
            
            Button("Cancel", role: .cancel){ }
        } message: {
            Text("Are you sure do you want to delete this book?")
        }
        .toolbar{
            ToolbarItem {
                Button("Delete this book", systemImage: "trash"){
                    showingDeleteAlert = true
                }
            }
        }
        
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

