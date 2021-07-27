//
//  ContentView.swift
//  TempConverter
//
//  Created by Shaurya Gulati on 03/06/21.
//

import SwiftUI

extension UnitLength: CaseIterable {
    public static var allCases: [UnitLength] {
        return [.feet, .meters, .inches]
    }
}

func UnitLengthDescription(_ unit: UnitLength) -> String {
    return unit.symbol
}

struct ContentView: View {
    
    @State private var input = "0.0"
    @State private var inputUnit: UnitLength = .feet
    @State private var outputUnit: UnitLength = .meters
    let units = UnitLength.allCases
    
    var output: Double{
        let inputValue = Double (input) ?? 0
        let measurement = Measurement(value: inputValue, unit: inputUnit)
        return measurement.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("From")){
                    TextField("Input Value", text: $input)
                        .keyboardType(.decimalPad)
                    
                    Picker("From", selection: $inputUnit){
                        ForEach(units, id: \.self){
                            Text("\(UnitLengthDescription($0))")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To")){
                    Picker("To", selection: $outputUnit){
                        ForEach(units, id: \.self){
                            Text("\(UnitLengthDescription($0))")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("\(output, specifier: "%.2f") \(outputUnit.symbol)")
                }
            }
            .navigationBarTitle("Height Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
