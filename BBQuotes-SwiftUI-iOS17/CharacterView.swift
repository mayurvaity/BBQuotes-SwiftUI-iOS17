//
//  CharacterView.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 06/07/24.
//

import SwiftUI

struct CharacterView: View {
    let character: Character
    let show: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                //bg image on top
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                
                //ScrollView - to add image and content
                ScrollView {
                    //to directly download image from url and show on the view
                    AsyncImage(url: character.images[0]) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        //to show loading icon while image is being downloaded
                        ProgressView()
                    }
                    .frame(width: geo.size.width/1.2,
                           height: geo.size.height/1.7) //to stop overflow of image below frame set for zstack
                    .clipShape(.rect(cornerRadius: 25))
                    .padding(.top, 60) //to add some space at the top
                    
                    
                    //VStack -  to contain all the details and add cutomizations to them
                    VStack(alignment: .leading)  {
                        Text(character.name)
                            .font(.largeTitle)
                        
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.subheadline)
                        
                        Divider() //to put a horizontal line
                        
                        Text("\(character.name) Character Info")
                            .font(.title2)
                        
                        Text("Born: \(character.birthday)")
                        
                        Divider()
                        
                        Text("Occupations: ")
                        
                        ForEach(character.occupations, id: \.self) {
                            occupation in
                            Text("• \(occupation)")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        Text("Nicknames:")
                        
                        //checking if there are any aliases avlbl for this character 
                        if character.aliases.count > 0 {
                            ForEach(character.aliases, id: \.self) {
                                alias in
                                Text("• \(alias)")
                                    .font(.subheadline)
                            }
                        } else {
                            Text("None")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        
                    }
                    .frame(width: geo.size.width/1.25, alignment: .leading) //to set width of vstack and alignment for all the view within it
//                    .border(.red)
                }
                .scrollIndicators(.hidden) // to hide the scrollbar
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character,
                  show: "Breaking Bad")
}
