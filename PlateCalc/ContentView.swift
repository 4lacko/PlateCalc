//
//  ContentView.swift
//  PlateCalc
//
//  Created by Ayo Moreira on 6/15/23.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var weightIsFocused: Bool
    @State private var targetWeight: Int?
    @State private var selectedBar = "Standard Bar"
    
    let bars = ["Standard Bar", "Trap Bar"]
    var barWeight: Int {
        if selectedBar == bars[0] {
            return 45
        } else {
            return 55
        }
    }
    
    @State private var plates = [Double]()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Target Weight")
                        Spacer()
                        TextField(
                            value: $targetWeight,
                            format: .number
                        ) {
                            Text("0")
                        }
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .focused($weightIsFocused)
                        .onTapGesture {
                            weightIsFocused = true
                        }
                        .onChange(of: targetWeight) { _ in
                            if targetWeight ?? 0 > 45 {
                                plates = calculatePlates(barWeight: barWeight, targetWeight: targetWeight ?? barWeight)
                            }
                        }
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                
                                Button("Done") {
                                    weightIsFocused = false
                                }
                            }
                        }
                    }
                }
                
                Picker("Bars", selection: $selectedBar) {
                    ForEach(bars, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .onChange(of: selectedBar) { _ in
                    if targetWeight ?? 0 > 45 {
                        plates = calculatePlates(barWeight: barWeight, targetWeight: targetWeight ?? barWeight)
                    }
                }
                
                Section {
                    if targetWeight != 0 {
                        ForEach(plates, id: \.self) { plate in
                            PlateRow(plate: plate)
                        }
                    }
                } header: {
                    Text("Plates (Each side)")
                }
                
            }
            .navigationTitle("Plate Calculator")
        }
    }
    
    func calculatePlates(barWeight: Int, targetWeight: Int) -> [Double] {
        let plateWeights = [45, 25, 10, 5, 2.5]
        var remainingWeight = Double(targetWeight - barWeight)
        var plates: [Double] = []
        
        for weight in plateWeights {
            let plateCount = Int(remainingWeight / (Double(weight) * 2))
            let totalPlateWeight = Double(plateCount) * Double(weight) * 2
            remainingWeight -= totalPlateWeight
            
            for _ in 0..<plateCount {
                plates.append(Double(weight))
            }
        }
        
        return plates
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
