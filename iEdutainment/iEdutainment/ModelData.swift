import Foundation

class ModelData: ObservableObject {
    @Published var numberQuestion: Int = 5
    @Published var multiplicationTable: Int = 2
    @Published var generatedQuestions: [Question] = [Question]()
    @Published var correctQuestions : Int = 0
    
    init() {
        initialiseGame()
    }
    
    func generateQuestions()  {
        var questions: [Question] = [Question]()
        for _ in 0..<self.numberQuestion {
            questions.append(Question(operands: (Int.random(in: 0...12), self.multiplicationTable)))
        }
        self.generatedQuestions = questions
    }
    
    func initialiseGame() {
        generateQuestions()
        correctQuestions = 0
    }
    
    func removeQuestion(byId id: UUID) {
        generatedQuestions.removeAll { $0.id == id }
    }
}
