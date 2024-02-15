//
//  String+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

enum EpisodeInfoError: Error, Comparable {
    case invalidFormat(_ format: String)
}

extension String {
    func parseEpisode() throws -> (season: Int, episode: Int) {
        let pattern = "^S(\\d+)E(\\d+)$"
        let regex = try NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: self.utf8.count)

        guard let match = regex.firstMatch(in: self, range: range) else {
            throw EpisodeInfoError.invalidFormat(self)
        }

        let seasonRange = Range(match.range(at: 1), in: self)!
        let episodeRange = Range(match.range(at: 2), in: self)!

        let season = Int(self[seasonRange])!
        let episode = Int(self[episodeRange])!
        
        return (season: season, episode: episode)
    }
}

extension String {
    func asInt() throws -> Int {
        guard let result = Int(self) else {
            throw NSError(domain: "\(self) could not be parsed to Int", code: 1)
        }
        
        return result
    }
}
