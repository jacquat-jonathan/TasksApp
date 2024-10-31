//
//  Occurence.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import Foundation
import SwiftData

@Model
class Occurence: Identifiable, ObservableObject {
    @Attribute(.unique) var id: UUID
    var dueDate: Date
    var isDone: Bool
    var task: Task
    
    init(dueDate: Date, task: Task) {
        self.id = UUID()
        self.dueDate = dueDate
        self.isDone = false
        self.task = task
    }
    
    init() {
        self.id = UUID()
        self.dueDate = .now
        self.isDone = false
        self.task = Task()
    }
    
    func setDone(_ state: Bool) {
        self.isDone = state
    }
    
    func setDueDate(_ date: Date) {
        self.dueDate = date
    }
    
}
