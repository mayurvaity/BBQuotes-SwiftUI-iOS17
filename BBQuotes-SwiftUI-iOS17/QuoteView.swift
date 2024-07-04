//
//  QuoteView.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 04/07/24.
//

import SwiftUI

struct QuoteView: View {
    
    //viewmodel obj
    let vm = ViewModel()
    
    //to keep selected show value
    let show: String
    
    var body: some View {
        //GeometryReader - to get dimensions of the device
        GeometryReader { geo in
            ZStack {
                //bg image
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .frame(width: geo.size.width * 2.7,
                           height: geo.size.height * 1.2)
                
                VStack {
                    Text("\"\(vm.quote.quote)\"")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.horizontal)
                    
                    ZStack(alignment: .bottom) {
                        //to directly download image from url and show on the view
                        AsyncImage(url: vm.character.images[0]) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            //to show loading icon while image is being downloaded
                            ProgressView()
                        }
                        .frame(width: geo.size.width/1.1,
                               height: geo.size.height/1.8) //to stop overflow of image below frame set for zstack
                        
                        //to add character name on image
                        Text(vm.quote.character)
                            .foregroundStyle(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial) //to add translucent bg
                    }
                    .frame(width: geo.size.width/1.1,
                           height: geo.size.height/1.8)
                    .clipShape(.rect(cornerRadius: 50))
                    
                }
                .frame(width: geo.size.width) //to keep all the view ini the vstack within width
                    
            }
            .frame(width: geo.size.width, height: geo.size.height) //to bring phone to center of the image
        }
        .ignoresSafeArea()
    }
    
    
}

#Preview {
    QuoteView(show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
