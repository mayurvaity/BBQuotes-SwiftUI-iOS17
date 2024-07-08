//
//  RandomCharacterView.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 09/07/24.
//

import SwiftUI

struct RandomCharacterView: View {
    let character: Character
    let geo: GeometryProxy
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.title)
            
            AsyncImage(url: character.images.randomElement()) {
                image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 15))
//                    .frame(height: geo.size.width)
            } placeholder: {
                ProgressView()
            }
            
            Text("Portrayed By: \(character.portrayedBy)")
            
            Text("Born: \(character.birthday)")
        }
        .frame(width: geo.size.width/1.2)
        .padding()
        .foregroundStyle(.white)
        .background(.black.opacity(0.6))
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal)
    }
}

#Preview {
    GeometryReader { geo in
        RandomCharacterView(character: ViewModel().character, geo: geo)
            .frame(width: geo.size.width, height: geo.size.height)
    }
    .ignoresSafeArea()
}
