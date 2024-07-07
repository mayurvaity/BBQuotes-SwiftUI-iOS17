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
            //ScrollViewReader - this vw will help with scrolling to desired locaiton in the screen
            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    //bg image on top
                    Image(show.removeSpacesAndCases())
                        .resizable()
                        .scaledToFit()
                    
                    //ScrollView - to add image and content
                    ScrollView {
                        //TabView - to show multiple images
                        TabView {
                            ForEach(character.images, id: \.self) {
                                characterImageURL in
                                //to directly download image from url and show on the view
                                AsyncImage(url: characterImageURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    //to show loading icon while image is being downloaded
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page) //to set tabvwstyle made for images (page style tab view), for tab bar it is .automatic
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
                            
                            //A view that shows or hides another content view, based on the state of a disclosure control.
                            DisclosureGroup("Status (Spoiler Alert!)") {
                                VStack(alignment: .leading) {
                                    //status dead/ alive
                                    Text(character.status)
                                        .font(.title2)
                                    
                                    //death details
                                    if let death = character.death {
                                        //death image
                                        //to directly download image from url and show on the view
                                        AsyncImage(url: death.image) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear {
                                                    //to show animation when automatic scrolling 
                                                    withAnimation {
                                                        //to scroll to the bottom of the screen when this image finishes loading
                                                        //1 - id, where to scroll
                                                        proxy.scrollTo(1, anchor: .bottom)
                                                    }
                                                }
                                            
                                        } placeholder: {
                                            //to show loading icon while image is being downloaded
                                            ProgressView()
                                        }
                                        
                                        //death details
                                        Text("How: \(death.details)")
                                            .padding(.bottom, 7)
                                        
                                        Text("Last words: \"\(death.lastWords)\"")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .tint(.primary)
                            
                        }
                        .frame(width: geo.size.width/1.25, alignment: .leading) //to set width of vstack and alignment for all the view within it
                        //                    .border(.red)
                        .padding(.bottom, 50)
                        .id(1)
                    }
                    .scrollIndicators(.hidden) // to hide the scrollbar
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CharacterView(character: ViewModel().character,
                  show: Constants.bbName)
}
