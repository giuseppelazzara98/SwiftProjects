
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Import a photo to get started"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                        .disabled(processedImage == nil)
                }
                
                
                HStack {
                    Button("Change filter", action: changeFilter)
                        .disabled(processedImage == nil)
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
                
                
            }
            .padding(.horizontal)
            .padding(.bottom)
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
                
            }
            
        }
        
        
        
    }
    
    func changeFilter() {
        showingFilters.toggle()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
        
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
        
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        filterCount += 1

        if filterCount >= 5 {
            requestReview()
        }
        currentFilter = filter
        loadImage()
    }
}

#Preview {
    ContentView()
}
