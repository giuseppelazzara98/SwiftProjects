import SwiftUI

struct Button3DRotAnim: View {
    @State private var animationAmount = 0.0
    var body: some View {
        Button("Tap Me"){
            withAnimation (.easeInOut(duration: 1)){
                animationAmount += 360
            }
            
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animationAmount),
                                  axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}

#Preview {
    Button3DRotAnim()
}
