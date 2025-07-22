//
//  SearchBar.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search repositories...", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            .frame(height: 60)
            .tint(Color(.label))
    }
}
