import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var points = 0
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .onSubmit {
                        addNewWord()
                    }
                }
                
                Section{
                    Text("Points: \(points)")
                }
                
                Section {
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            Text(word)
                            Spacer()
                            Image(systemName: "\(word.count).circle")
                        }
                        
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle(rootWord)
            .toolbar{
                Button("Restart"){
                    startGame()
                    points = 0
                    usedWords = []
                }
            }
        }.onAppear(perform: {
            startGame()
        })
        .alert(errorTitle, isPresented: $showingError){}
    message: {
            Text(errorMessage)
    }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespaces)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isMoreThanThreeChar(word: answer) else {
            wordError(title: "Word is too short", message: "Come on, you can do better!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isNotTheRootWord(word: answer) else {
            wordError(title: "The word is the same", message: "Come on, be more creative!")
            return
        }
        
        
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        
        points += 1
        newWord = ""
    }
    
    func startGame(){
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load Words File in Bundle")
    }
    
    func isOriginal(word:String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word:String) -> Bool {
        var tempWord = rootWord
        
        for lett in word {
            if let pos = tempWord.firstIndex(of: lett){
                tempWord.remove(at: pos)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isNotTheRootWord(word: String) -> Bool {
        return word != rootWord
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isMoreThanThreeChar(word: String) ->Bool{
        return word.count > 3
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    

}

#Preview {
    ContentView()
}
