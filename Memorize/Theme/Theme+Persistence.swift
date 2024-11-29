//
//  Theme+Persistence.swift
//  Memorize
//
//  Created by Denis Avdeev on 29.11.2024.
//

import Foundation

extension Array where Element == Theme {
    
    func autosave() {
        save(to: Self.autosaveURL)
        print("Autosaved to \(Self.autosaveURL)")
    }
    
    static func load() -> [Theme]? {
        (try? Data(contentsOf: autosaveURL))
            .flatMap { try? .init(json: $0) }
    }
}

private extension Array where Element == Theme {
    
    static let autosaveURL = URL.documentsDirectory
        .appendingPathComponent("Autosaved.memorize")
    
    func save(to url: URL) {
        do {
            let data = try json()
            try data.write(to: url)
        } catch let error {
            print("Error while saving \(error.localizedDescription)")
        }
    }
    
    func json() throws -> Data {
        let data = try JSONEncoder().encode(self)
        let result = String(data: data, encoding: .utf8) ?? "null"
        
        print("Theme encoded to \(result)")
        return data
    }
    
    init(json: Data) throws {
        self = try JSONDecoder()
            .decode(Self.self, from: json)
    }
}

// a quick and dirty approach taken from a discussion
// at https://forums.swift.org/t/why-is-character-not-codable
extension Character: Codable {
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(String(describing: self))
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let s = try container.decode(String.self)
        self = s.count == 1 ? s.first! : "\u{FFFD}"
    }
}
