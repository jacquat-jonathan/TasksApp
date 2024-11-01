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

    init() {}

    init(occurrence: Occurrence) {
        self.occurrence = occurrence
    }

    func save(context: ModelContext) {}

    var canSave: Bool {
        guard !occurrence.task.title.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return false
        }
        guard occurrence.task.dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
