import CoreML
import SwiftUI



struct ContentView: View {
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeAmount = 1
    
    
  
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    
                    DatePicker("Please enter a time" ,selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                }
                Section ("Desired amount of sleep"){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section ("Daily Coffee intake"){
                    
                    
                    
                    Picker("Number of cups", selection: $coffeAmount) {
                        ForEach(0..<11) {
                            Text("\($0) " + ($0 > 1 ? "cups" : "cup"))
                        }
                    }
                    
                    
                    
                }
                Section{
                    Text("Your ideal badtime is: ").bold()
                    Text(calculateBedtime())
                    
                }
                
                
            }
            .navigationTitle("BetterRest")
            
            
        }
    }
    

    
    
        func calculateBedtime() -> String {
            do {
                let config = MLModelConfiguration()
                let model = try SleepCalculator(configuration: config)
                
                let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
                let hour = (components.hour ?? 0) * 60 * 60
                let minute = (components.minute ?? 0) * 60
                
                let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
                
                let sleep_time = wakeUp - prediction.actualSleep
                
                return sleep_time.formatted(date: .omitted, time: .shortened)
            } catch {
                return "Error"
            }}
        
        
    }


#Preview {
    ContentView()
}
