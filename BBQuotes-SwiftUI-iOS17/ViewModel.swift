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
        case success
        case failed(error: Error)
    }
    
    //initializing status variable
    //private(set) - outsiders can get this property but they can't set it
    private(set) var status: FetchStatus = .notStarted
    
    //creating obj of FetchService
    private let fetcher = FetchService()
    
    //vars to store quote and character, to be used in view
    var quote: Quote
    var character: Character
    
    //initializing vars with sample data
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Character.self, from: characterData)
    }
    
    //to get data based on show selected
    func getData(for show: String) async {
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
            status = .success
        } catch {
            //setting status to failed if anything fails while fetching data from web
            status = .failed(error: error)
        }
    }
    
}
