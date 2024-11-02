//
//  CRUDInterface.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import Foundation
import SwiftData

class CRUDInterface: ObservableObject {
    @Published var showAlert = false
    @Published var occurrence: Occurrence = Occurrence()
    @Published var updateAll: Bool = false
    @Published var create: Bool = false

    init() {
        self.create = true
    }

    init(occurrence: Occurrence) {
        self.occurrence = occurrence
    }
    
    init(occurrence: Occurrence, updateAll: Bool) {
        self.occurrence = occurrence
        self.updateAll = updateAll
    }

    func save(context: ModelContext) {}
    
    func getNextDate(by: RepetitionTypeEnum, to: Date, value: Int) -> Date {
        let calendar = Calendar.current
        switch by {
        case .daily:
            return calendar.date(byAdding: .day, value: value, to: to)!
        case .weekly:
            return calendar.date(byAdding: .day, value: 7 * value, to: to)!
        case .monthly:
            return calendar.date(byAdding: .month, value: value, to: to)!
        case .yearly:
            return calendar.date(byAdding: .year, value: value, to: to)!
        case .no:
            return to
        }
    }

    var canSave: Bool {
        guard !occurrence.title.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return false
        }
        guard occurrence.dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
