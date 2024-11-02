//
//  Occurrence.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import Foundation
import SwiftData

@Model
class Occurrence: Identifiable, ObservableObject {
    @Attribute(.unique) var id: UUID
    var title: String
    var priority: Int
    var dueDate: Date
    var isDone: Bool
    var hasReminder: Bool
    var task: Task
    
    init(title: String, dueDate: Date, priority: Int, hasReminder: Bool, task: Task) {
        self.id = UUID()
        self.dueDate = dueDate
        self.isDone = false
        self.task = task
        self.title = title
        self.priority = priority
        self.hasReminder = hasReminder
    }
    
    init() {
        self.id = UUID()
        self.dueDate = .now
        self.isDone = false
        self.task = Task()
        self.title = ""
        self.priority = PriorityEnum.low.rawValue
        self.hasReminder = false
    }
    
    func setDone(_ state: Bool) {
        self.isDone = state
    }
    
    func setDueDate(_ date: Date) {
        self.dueDate = date
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setTask(_ task: Task) {
        self.task = task
    }
    
    func setPriority(_ priority: Int) {
        self.priority = priority
    }
    
    func setHasReminder(_ state: Bool) {
        self.hasReminder = state
    }
}
