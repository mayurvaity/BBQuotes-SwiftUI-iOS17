//
//  Quote.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 03/07/24.
//

import Foundation

struct Quote: Decodable {
    let quote: String
    let character: String
    //optional image added to get image data that comes with Simpsons API 
    let image: URL?
}
