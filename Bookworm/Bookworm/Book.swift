//
//  Book.swift
//  Bookworm
//
//  Created by Giuseppe Lazzara on 26/06/24.
//
import SwiftData
import Foundation

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: String
    var isValid: Bool {
        if title.isEmpty || author.isEmpty || genre.isEmpty || review.isEmpty ||  !(0...5).contains(rating) {
            return false
        }
        return true
    }
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        self.date = dateFormatter.string(from: Date())
    }
}
