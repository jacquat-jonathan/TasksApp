//
//  Category.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import Foundation
import SwiftData

@Model
class Category: ObservableObject, Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var tasks: [Task]
    
    init(name: String, tasks: [Task]) {
        self.id = UUID()
        self.name = name
        self.tasks = tasks
    }
}
