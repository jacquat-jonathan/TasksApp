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
    var dueDate: Date
    var repetitionType: Int
    var repetitionCount: Int
    var occurrences: [Occurrence]
    var group: Group?
    var category: Category?

    init(
        dueDate: Date, repetitionType: Int, repetitionCount: Int, occurrences: [Occurrence], group: Group?
    ) {
        self.id = UUID()
        self.dueDate = dueDate
        self.repetitionType = repetitionType
        self.repetitionCount = repetitionCount
        self.occurrences = occurrences
        self.group = group
    }

    init() {
        self.id = UUID()
        self.dueDate = .now
        self.repetitionType = RepetitionTypeEnum.no.rawValue
        self.repetitionCount = 0
        self.occurrences = []
    }

    func setDueDate(_ date: Date) {
        self.dueDate = date
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
