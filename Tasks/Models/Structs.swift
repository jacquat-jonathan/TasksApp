//
//  Structs.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import Foundation

struct ListSection: Identifiable {
    var id: UUID
    var date: Date
    var occurences: [Occurence]
    
    init(date: Date, occurences: [Occurence]) {
        self.id = UUID()
        self.date = date
        self.occurences = occurences
    }
}
