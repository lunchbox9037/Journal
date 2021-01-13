//
//  Entry.swift
//  Journal
//
//  Created by stanley phillips on 1/11/21.
//

import Foundation

class Entry: Codable {
    var title: String
    var body: String
    var timestamp: Date
    
    init(title: String, body: String, timestamp: Date = Date()){
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

//makes our entry object equatable by comparing the timestamps
extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.timestamp == rhs.timestamp
    }
}
