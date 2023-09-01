//
//  ContentView.swift
//  UnitConverter
//
//  Created by Oluwapelumi Williams on 01/09/2023.
//

import SwiftUI

// function for temperature conversion
func convertTemperature(currentValue: Double, from currentUnit: String, to targetUnit: String) -> Double {
    var targetValue: Double = 0
    
    // convert to a common unit: celsius first
    switch(currentUnit) {
    case "Kelvin":
        targetValue = currentValue - 273.15
    case "Farenheit":
        targetValue = (currentValue - 32) * 5/9
    default:
        // default is celsius, which is where we first convert to
        targetValue = currentValue
    }
    
    // now convert from celsius to the target unit
    switch(targetUnit) {
    case "Kelvin":
        targetValue = targetValue + 273.15
    case "Farenheit":
        targetValue = (currentValue * 5/9) + 32
    default:
        targetValue *= 1
    }
    
    return targetValue
}


// function for length conversion
func convertLength(currentValue: Double, from currentUnit: String, to targetUnit: String) -> Double {
    var targetValue: Double = 0
    
    // convert to a common unit: meters first
    switch(currentUnit) {
    case "Kilometers":
        targetValue = currentValue * 1000
    case "Feet":
        targetValue = currentValue / 3.281
    case "Yards":
        targetValue = currentValue / 1.094
    case "Miles":
        targetValue = currentValue * 1609
    default:
        // default is meters, which is where we first convert to
        targetValue = currentValue
    }
    
    // now convert from meters to the target unit
    switch(targetUnit) {
    case "Kilometers":
        targetValue = targetValue / 1000
    case "Feet":
        targetValue = targetValue * 3.281
    case "Yards":
        targetValue = targetValue * 1.094
    case "Miles":
        targetValue = targetValue / 1609
    default:
        targetValue *= 1
    }
    
    return targetValue
}


// function for volume conversion
func convertVolume(currentValue: Double, from currentUnit: String, to targetUnit: String) -> Double {
    var targetValue: Double = 0
    
    // convert to a common unit: liters first
    switch(currentUnit) {
    case "Milliliters":
        targetValue = currentValue / 1000
    case "Cups":
        // the imperial cup is what I used. there is also a us legal cup, which is not what I used
        targetValue = currentValue / 3.52
    case "Pints":
        // the imperial pint is what I used. there is also a us pint cup, which is not what I used
        targetValue = currentValue / 1.76
    case "Gallons":
        // the imperial gallon is what I used. there is also a us gallon, which is not what I used
        targetValue = currentValue * 4.546
    default:
        // default is liters, which is where we first convert to
        targetValue = currentValue
    }
    
    // now convert from liters to the target unit
    switch(targetUnit) {
    case "Milliliters":
        targetValue = targetValue * 1000
    case "Cups":
        targetValue = targetValue * 3.52
    case "Pints":
        targetValue = targetValue * 1.76
    case "Gallons":
        targetValue = targetValue / 4.546
    default:
        targetValue *= 1
    }
    
    return targetValue
}


// function to convert time
func convertTime(currentValue: Double, from currentUnit: String, to targetUnit: String) -> Double {
    var targetValue: Double = 0
    
    // convert to a common unit: seconds first
    switch(currentUnit) {
    case "Minutes":
        targetValue = currentValue * 60
    case "Hours":
        targetValue = currentValue * 60 * 60
    case "Days":
        targetValue = currentValue * 24 * 60 * 60
    default:
        // default is seconds, which is where we first convert to
        targetValue = currentValue
    }
    
    // now convert from seconds to the target unit
    switch(targetUnit) {
    case "Minutes":
        targetValue = targetValue / 60
    case "Hours":
        targetValue = targetValue / (60 * 60)
    case "Days":
        targetValue = targetValue / (24 * 60 * 60)
    default:
        targetValue *= 1
    }
    
    return targetValue
}

struct ContentView: View {
    
    var quantities = ["Temperature", "Length", "Time", "Volume"]
    @State var quantity = "Temperature"
    
    var units: [String] {
        switch(quantity) {
        case "Length":
            return ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
        case "Time":
            return ["Seconds", "Minutes", "Hours", "Days"]
        case "Volume":
            return ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
        default:
            return ["Celsius", "Farenheit", "Kelvin"]
        }
    }
    
    @State var currentUnit = "Celsius"
    @State var targetUnit = "Celsius"
    @State var value: Double = 0
    var targetValue: Double {
        switch(quantity) {
        case "Length":
            return convertLength(currentValue: value, from: currentUnit, to: targetUnit)
        case "Time":
            return convertTime(currentValue: value, from: currentUnit, to: targetUnit)
        case "Volume":
            return convertVolume(currentValue: value, from: currentUnit, to: targetUnit)
        default:
        // case "Temperature":
            return convertTemperature(currentValue: value, from: currentUnit, to: targetUnit)
        }
    }
    @FocusState private var valueIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Quantity", selection: $quantity) {
                        ForEach(quantities, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Picker("From", selection: $currentUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    TextField("Value", value: $value, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                }
                
                Section {
                    Picker("To", selection: $targetUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    Text("\(targetValue.formatted(.number.precision(.fractionLength(3))))")
                }
            }
                .navigationTitle("Unit Converter")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            valueIsFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
