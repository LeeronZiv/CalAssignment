//
//  LabelValueText.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import SwiftUI


struct LabelValueText: View {
    var label: String
    var value: String
    var font: Font = .system(size: 12)
    
    var body: some View {
        HStack(spacing: 2) {
            Text(label)
                .font(font)
                .fontWeight(.semibold)

            Text(value)
                .font(font)
                .fontWeight(.regular)
        }
    }
    
    
    func font(_ font: Font) -> LabelValueText {
        var copy = self
        copy.font = font
        return copy
    }
}
