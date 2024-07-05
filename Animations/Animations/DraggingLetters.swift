import SwiftUI

struct DraggingLetters: View {
    let letters = Array("Hello SwiftUI")
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    
    var body: some View {
        HStack {
            ForEach(0..<letters.count, id: \.self){
                num in
                Letter(letter: String(letters[num]))
                
                    
            }
        }
        
            
    }
}


struct Letter: View {
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    var letter: String
    var body: some View {
        Text(letter)
            .padding(5)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .background(enabled ? .blue : .red)
            .offset(dragAmount)
            .gesture(DragGesture()
                .onChanged(){
                    dragAmount
                    = $0.translation
                }
                .onEnded(){_ in
                    withAnimation(){
                        dragAmount = .zero
                        enabled.toggle()
                    }
                })
       
    }
}

#Preview {
    DraggingLetters()
}
