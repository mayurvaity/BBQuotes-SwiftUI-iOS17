//
//  ViewModel.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 04/07/24.
//

import Foundation

@Observable
class ViewModel {
    //enum to keep all diff types of fetch status
    enum FetchStatus {
        case notStarted
        case fetching
        case successQuote
        case successEpisode
        case successCharacter
        case failed(error: Error)
    }
    
    //initializing status variable
    //private(set) - outsiders can get this property but they can't set it
    private(set) var status: FetchStatus = .notStarted
    
    //creating obj of FetchService
    private let fetcher = FetchService()
    
    //vars to store quote, character & episode, to be used in view
    var quote: Quote
    var character: Character
    var episode: Episode
    
    //initializing vars with sample data
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Character.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(Episode.self, from: episodeData)
        
    }
   
    
    //to get random quote data based on show selected
    func getQuoteData(for show: String) async {
        //updating status
        status = .fetching
        
        do {
            //getting quote data using fetchQuote fn
            quote = try await fetcher.fetchQuote(from: show)
            
            //getting character data using fetchCharacter fn
            character = try await fetcher.fetchCharacter(quote.character)
            
            //getting death data for character
            character.death = try await fetcher.fetchDeath(for: quote.character)
            
            //setting status to success
            status = .successQuote
        } catch {
            //setting status to failed if anything fails while fetching data from web
            status = .failed(error: error)
        }
    }
    
    //to get random episode based on selected show
    func getEpisodeData(for show: String) async {
        //updating status
        status = .fetching
        
        do {
            //checking if episode data is available, if available assigning it to the episode var
            if let unwrappedEpisode = try await fetcher.fetchEpisode(from: show) {
                episode = unwrappedEpisode
                
                //setting status to success
                status = .successEpisode
            }
        } catch {
            //setting status to failed if anything fails while fetching data from web
            status = .failed(error: error)
        }
    }
    
    //to get random character based on selected show
    func getCharacterData(for show: String) async {
        //updating status
        status = .fetching
        
        do {
            //var to store productions of the character
            var productions: [String] = []
            
            //loop to keep searching for random character until productions list containing our show doesnot show up
            while(!productions.contains(show)) {
                //fetching random character
                character = try await fetcher.fetchRandomCharacter()
                
                //setting productions list to our variable, to check while looping
                productions = character.productions
                
            }
            //setting status to success
            status = .successCharacter
            
        } catch {
            //setting status to failed if anything fails while fetching data from web
            status = .failed(error: error)
        }
    }
}
