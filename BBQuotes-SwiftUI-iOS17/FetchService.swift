//
//  FetchService.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 04/07/24.
//

import Foundation


struct FetchService {
    enum FetchError: Error {
        case badResponse
    }
    
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        //build fetch url
        var quoteURL = baseURL.appending(path: "quotes/random")
        var fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        //fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        //decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        //return quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Character {
        //build fetch url
        var characterURL = baseURL.appending(path: "characters")
        var fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        //fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        //decode data
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let character = try decoder.decode([Character].self, from: data)
        
        //return quote
        return character[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        //build fetch url
        var fetchURL = baseURL.appending(path: "deaths")
        
        //fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        //decode data
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        
        //return quote
        return nil
    }
    
}
