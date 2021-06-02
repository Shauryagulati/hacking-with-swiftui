//
//  ContentView.swift
//  WeSplit
//
//  Created by Shaurya Gulati on 06/05/21.
//

import SwiftUI

struct ContentView: View {
        
    let tipPercentages = [10,15,20,25,0]
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    var totalPerPerson: Double {
        //Calculate the Total Per Person Here
        let peopleCount = Double(numberOfPeople) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal : Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
        Form{
            /* This will create a scrolling entry form of one section, which in turn contains one row: our text field */
            
            Section{
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
                
                /* The first parameter is a string that gets used as the placeholder – gray text shown in side the text field, giving users an idea of what should be in there. The second parameter is the two-way binding to our checkAmount property, which means as the user types that property will be updated */
                
                TextField("Number of People", text: $numberOfPeople)
                    .keyboardType(.numberPad)
//                Picker("Number of People", selection: $numberOfPeople){
//                    ForEach(2 ..< 100){
//                        Text("\($0) People")
//                    }
//                }
            }
            
            Section(header: Text("How much Tip do you want to leave?")){
                Picker("Tip Percentage", selection: $tipPercentage){
                    ForEach (0 ..< tipPercentages.count){
                        Text("\(self.tipPercentages[$0])%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Total Amount")){
                Text("$\(grandTotal, specifier: "%.2f")")
            }
            
            Section(header: Text("Amount per Person")){
                Text("$\(totalPerPerson, specifier: "%.2f")")
            }
        }
        .navigationTitle("WeSplit")
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
