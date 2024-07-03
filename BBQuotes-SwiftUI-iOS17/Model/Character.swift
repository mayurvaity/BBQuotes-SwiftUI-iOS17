//
//  Character.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 03/07/24.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL] //swift comes with automatic converter for string to URLs
    let aliases: [String]
    let status: String
    let portrayedBy: String 
    
}
