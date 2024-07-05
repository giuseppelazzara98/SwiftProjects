//
import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.black)
            .padding()
            .background(.white)
            .cornerRadius(10)
    }
}

extension View {
    func titleStyle () -> some View {
        modifier(TitleStyle())
    }
}


struct FlagImage: View {
    let image: String
    
    var body: some View {
        Image(image)
            .padding(1)
            .background(.black)
    }
}


struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var showingScore = false
    @State private var showFinalAlert = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var degreeRotation = Array(repeating: 0.0, count: 3)
    @State private var fadeLevel = Array(repeating: 1.0, count: 3)

    
    var body: some View {
        
        VStack (spacing: 30){
            VStack{
                Text("Actual Score: \(userScore)").padding(.bottom).titleStyle()
                
                Text("Tap the flag of")
                Text(countries[correctAnswer])
            }
            ForEach(0..<3) {number in
                Button{
                    flagTapped(number)
                    withAnimation(.easeInOut(duration: 1)){
                        degreeRotation[number] += 360
                        fadeLevel = fadeLevel.enumerated().map { $0.offset == number ? 1.0 : 0.25 }
                    }
                }
            label: {
                FlagImage(image: countries[number])
            }.rotationEffect(.degrees(degreeRotation[number]), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .opacity(fadeLevel[number])
                    
                    
            
            .alert(scoreTitle, isPresented: $showingScore){
                    
                Button("Ok"){
                    withAnimation(.smooth){
                        shuffle()
                        fadeLevel = Array(repeating: 1.0, count: 3)
                    }}
                } message: {
                    
                    Text("Actual Score:\(userScore)")
                }.alert("You Win",isPresented: $showFinalAlert){
                    Button("Ok"){
                        
                    }
                }
            }
            
            Spacer()
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            userScore += 1
            if userScore == 8{
                reset()
            }
            else {
                scoreTitle = "Correct"
                showingScore = true
            }
            
        }
        else {
            userScore = max(userScore - 1, 0)
            scoreTitle = "Wrong this is the flag of \(countries[number])"
            showingScore = true
        }
        
        
    }
    
     func shuffle(){
        countries.shuffle()
         correctAnswer = Int.random(in: 0...2)
         
            }
    
    func reset(){
        showFinalAlert = true
        userScore = 0
    }
}

#Preview {
    ContentView()
}
