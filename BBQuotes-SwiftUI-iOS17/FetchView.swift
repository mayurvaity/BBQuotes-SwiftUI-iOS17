//
//  FetchView.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 04/07/24.
//

import SwiftUI

struct FetchView: View {
    
    //viewmodel obj
    let vm = ViewModel()
    
    //to keep selected show value
    let show: String
    
    //to store bool of if to show character info
    @State var showCharacterInfo: Bool = false
    
    var body: some View {
        //GeometryReader - to get dimensions of the device
        GeometryReader { geo in
            ZStack {
                //bg image
                Image(show.removeSpacesAndCases())
                    .resizable()
                    .frame(width: geo.size.width * 2.7,
                           height: geo.size.height * 1.2) //this frame overrides restrictions put by frame of zstack, that's why we need another frame for vstack
                
                VStack {
                    VStack {
                        Spacer(minLength: 60) //to maintain min distance from top of the screen
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                            
                        case .successQuote:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5) //to set minimum font size if a quote (a large one) could not fit in there
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
                            .onTapGesture {
                                //toggling show character view var property when tapped up on this view
                                showCharacterInfo.toggle()
                            }
                        
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                            
                        }
                        
                        //minLength - to specify minimum space size 
                        Spacer(minLength: 20)
                        
                    }
                    
                    HStack {
                        //get quote button
                        Button {
                            //Task - to call async functions, async fns cannot be called in the swiftui directly hence need to b put in task
                            Task {
                                //calling get data fn from viewmodel, which will inturn fetch quote data from urls and
                                await vm.getQuoteData(for: show)
                            }
                        } label: {
                            Text("Get Random Quote")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(show.removeSpaces())Shadow"), radius: 2)
                        }
                        
                        Spacer()
                        
                        //get episode button
                        Button {
                            //Task - to call async functions, async fns cannot be called in the swiftui directly hence need to b put in task
                            Task {
                                //calling get data fn from viewmodel, which will inturn fetch episode data from urls and
                                await vm.getEpisodeData(for: show)
                            }
                        } label: {
                            Text("Get Random Episode")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(show.removeSpaces())Shadow"), radius: 2)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    //spacer below buttons
                    Spacer(minLength: 95) //minlength - this spacer viw has to take space of at least 95
                    
                }
                .frame(width: geo.size.width, height: geo.size.height) //to keep all the view in the vstack within width and height
                
            }
            .frame(width: geo.size.width, height: geo.size.height) //to bring phone to center of the image
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo, content: {
            //to show character view in Modal form when value of $showCharacterInfo gets changed 
            CharacterView(character: vm.character,
                          show: show)
        })
    }
    
    
}

#Preview {
    FetchView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}
