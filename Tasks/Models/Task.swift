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
    var occurrences: [Occurrence]
    var group: Group?
    var category: Category?

    init(
        title: String, priority: Int, dueDate: Date, hasReminder: Bool,
        repetitionType: Int, repetitionCount: Int, occurrences: [Occurrence], group: Group?
    ) {
        self.id = UUID()
        self.title = title
        self.priority = priority
        self.dueDate = dueDate
        self.hasReminder = hasReminder
        self.repetitionType = repetitionType
        self.repetitionCount = repetitionCount
        self.occurrences = occurrences
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
        self.occurrences = []
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

    func setOccurrences(_ occurrences: [Occurrence]) {
        self.occurrences = occurrences
    }

    func addOccurrence(_ occurrence: Occurrence) {
        self.occurrences.append(occurrence)
    }

    func removeOccurrence(_ occurrence: Occurrence) {
        self.occurrences.removeAll(where: { $0.id == occurrence.id })
    }
}
