//
//  ContentView.swift
//  BetterRest
//
//  Created by Shaurya Gulati on 09/06/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
//                VStack (alignment: .leading, spacing: 0) {
//                    Text("When do you want to wake up?")
//                        .font(.headline)
//                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                        .datePickerStyle(WheelDatePickerStyle())
//                }
                Section(header: Text("When do you want to wake up?").font(.headline)){
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                        .frame(height: 175)
                        .clipped()
                }

//                VStack (alignment: .leading, spacing: 0){
//                    Text("Desired Amount of Sleep")
//                        .font(.headline)
//                    Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25){
//                        Text("\(sleepAmount, specifier: "%g") hours")
//                    }
//                }
                Section(header: Text("Desired Maount of Sleep").font(.headline)){
                    Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25){
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    .clipped()
                }
                
//                VStack (alignment: .leading, spacing: 0){
//                    Text("Daily Coffee Intake")
//                        .font(.headline)
//                    Stepper(value: $coffeeAmount, in: 1 ... 20) {
//                        if coffeeAmount == 1 {
//                            Text("1 Cup")
//                        } else {
//                            Text("\(coffeeAmount) Cups")
//                        }
//                    }
//                }
                Section(header: Text("Daily Coffee Intake").font(.headline)){
                    Picker("Select number of cups", selection: $coffeeAmount){
                        ForEach (1 ... 20, id: \.self) { cups in
                            (cups == 1) ? Text("1 Cup") : Text("\(cups) Cups")
                        }
                    }
                    .frame(height: 75)
                    .clipped()
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                }
                
                Section(header: Text("Your Ideal Bed Time is").font(.headline)) {
                    Text(calculateBedTime)
                        .font(Font.title.monospacedDigit())
                }
            }
            .navigationTitle("BetterRest")
//            .navigationBarItems(trailing: Button(action: calculateBedTime) {
//                Text("Calculate")
//            })
            
//            .alert(isPresented: $showingAlert){
//                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
//            }
        }
    }
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    
    var calculateBedTime: String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        }
        catch {
            // Something went Wrong !
            return "Error Calculating"
        }
//        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
