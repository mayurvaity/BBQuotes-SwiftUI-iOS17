//
//  StringExt.swift
//  BBQuotes-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 07/07/24.
//

import Foundation

//extension of string 
extension String {
    //fn to remove spaces from string
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    //fn to remove spaces and make lower case
    func removeSpacesAndCases() -> String {
        self.removeSpaces().lowercased()
    }
}
