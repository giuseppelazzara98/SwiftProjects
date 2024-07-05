//
//  SwiftUIView.swift
//  Instafilter
//
//  Created by Giuseppe Lazzara on 02/07/24.
//

import SwiftUI
import PhotosUI
import StoreKit

struct SwiftUIView: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    @Environment(\.requestReview) var requestReview
    var body: some View {
        
        let example = Image(.thriller)

        ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
            Label("Click to share", systemImage: "airplane")
        }
        Button("Leave a Review") {
            requestReview()
        }
        
        
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet.")
            ScrollView {
                ForEach(0..<selectedImages.count, id:\.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
                
            }
        } actions: {
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 2, matching: .images) {
                Label("Select a picture", systemImage: "photo")
            }
                .onChange(of: pickerItems){
                    Task {
                        selectedImages.removeAll()
                        for pickerItem in pickerItems {
                            if let loadedImage = try await pickerItem.loadTransferable(type: Image.self) {
                                selectedImages.append(loadedImage)
                            }
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    SwiftUIView()
}
