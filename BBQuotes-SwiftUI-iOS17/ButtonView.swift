//
//  ButtonView.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 08/07/24.
//

import SwiftUI

struct ButtonView: View {
    var buttonText: String
    var show: String
    
    var body: some View {
        Text(buttonText)
            .font(.caption)
            .foregroundStyle(.white)
            .padding()
            .background(Color("\(show.removeSpaces())Button"))
            .clipShape(.rect(cornerRadius: 7))
            .shadow(color: Color("\(show.removeSpaces())Shadow"), radius: 2)
    }
}

#Preview {
    ButtonView(buttonText: "Get Random Episode", show: "Better Call Saul")
}
