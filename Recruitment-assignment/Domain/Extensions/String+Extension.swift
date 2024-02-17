//
//  String+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

enum ParsingError: Error, Comparable {
    case invalidFormat(_ format: String)
    case couldNotParse(_ stringValue: String, toType: String)
}

extension String {
    func parseEpisode() throws -> (season: Int, episode: Int) {
        let pattern = "^S(\\d+)E(\\d+)$"
        let regex = try NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: self.utf8.count)

        guard let match = regex.firstMatch(in: self, range: range) else {
            throw ParsingError.invalidFormat(self)
        }

        let seasonRange = Range(match.range(at: 1), in: self)!
        let episodeRange = Range(match.range(at: 2), in: self)!

        let season = Int(self[seasonRange])!
        let episode = Int(self[episodeRange])!
        
        return (season: season, episode: episode)
    }
}

extension String{
    static func random(in range: Range<Int>) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = Int.random(in: range.lowerBound...range.upperBound)
        let characters = (0...length).map { _ in letters.randomElement()! }
        return String(characters)
    }
}

extension String {
    func asInt() throws -> Int {
        guard let result = Int(self) else {
            throw ParsingError.couldNotParse(self, toType: String(describing: Int.self))
        }
        
        return result
    }
}
