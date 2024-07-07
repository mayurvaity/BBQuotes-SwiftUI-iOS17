//
//  Episode.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 07/07/24.
//

import Foundation

struct Episode: Decodable {
    let episode: Int
    let title: String
    let image: URL
    let synopsis: String
    let writtenBy: String
    let directedBy: String
    let airDate: String
    
    //calculated variable to get complete episode number from episode int 
    var seasonEpisode: String {
        var episodeString = String(episode)
        let season = episodeString.removeFirst() //removes 1st character and returns it
        
        if episodeString.first! == "0" {
            episodeString = String(episodeString.removeLast()) //removes last character and returns it
        }
        
        return "Season \(season) Episode \(episodeString)"
    }
}
