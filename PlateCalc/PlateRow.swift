//
//  PlateRow.swift
//  PlateCalc
//
//  Created by Ayo Moreira on 6/15/23.
//

import SwiftUI

struct PlateRow: View {
    var plate: Plate
    
    var body: some View {
        HStack {
            Circle()
                .fill(.black)
                .frame(width: 30, height: 30)
                .padding(EdgeInsets(top: 3.009, leading: 0, bottom: 3.009, trailing: 5))
            
            Text("\(plateString(for: plate.plateWeight)) lb x \(plate.count)")
            
            Spacer()
        }
    }
    
    private func plateString(for plate: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = plate == 2.5 ? 1 : 0
        formatter.maximumFractionDigits = plate == 2.5 ? 1 : 0
        return formatter.string(from: NSNumber(value: plate)) ?? ""
    }
}



struct PlateRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlateRow(plate: Plate(plateWeight: 45.0, count: 3))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
