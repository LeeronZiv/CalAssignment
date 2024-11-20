//
//  View.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 20/11/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func addLabelValueText(label: String, value: String, font: Font = .system(size: 12)) -> some View {
        if !value.isEmpty {
            LabelValueText(label: label, value: value, font: font)
        }
    }
}
