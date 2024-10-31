//
//  Task.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import Foundation
import SwiftData

@Model
class Task: Identifiable, ObservableObject {
    @Attribute(.unique) var id: UUID
    var title: String
    var priority: Int
    var dueDate: Date
    var hasReminder: Bool
    var repetitionType: Int
    var repetitionCount: Int
    var occurences: [Occurence]
    var group: Group?
    var category: Category?

    init(
        title: String, priority: Int, dueDate: Date, hasReminder: Bool,
        repetitionType: Int, repetitionCount: Int, occurences: [Occurence], group: Group?
    ) {
        self.id = UUID()
        self.title = title
        self.priority = priority
        self.dueDate = dueDate
        self.hasReminder = hasReminder
        self.repetitionType = repetitionType
        self.repetitionCount = repetitionCount
        self.occurences = occurences
        self.group = group
    }
    
    init() {
        self.id = UUID()
        self.title = "Ceci est une tâche test"
        self.priority = PriorityEnum.low.rawValue
        self.dueDate = .now
        self.hasReminder = false
        self.repetitionType = RepetitionTypeEnum.no.rawValue
        self.repetitionCount = 0
        self.occurences = []
    }

    func setTitle(_ title: String) {
        self.title = title
    }

    func setPriority(_ prio: Int) {
        self.priority = prio
    }

    func setDueDate(_ date: Date) {
        self.dueDate = date
    }

    func setHasReminder(_ state: Bool) {
        self.hasReminder = state
    }

    func setRepetitionType(_ value: Int) {
        self.repetitionType = value
    }

    func setRepetitionCount(_ count: Int) {
        self.repetitionCount = count
    }

    func setRepetition(type: Int, count: Int) {
        self.repetitionType = type
        self.repetitionCount = count
    }

    func setOccurences(_ occurences: [Occurence]) {
        self.occurences = occurences
    }

    func addOccurence(_ occurence: Occurence) {
        self.occurences.append(occurence)
    }

    func removeOccurence(_ occurence: Occurence) {
        self.occurences.removeAll(where: { $0.id == occurence.id })
    }
}
