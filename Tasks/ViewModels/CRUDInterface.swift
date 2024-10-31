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
    @Published var occurence: Occurence = Occurence()

    init() {}

    init(occurence: Occurence) {
        self.occurence = occurence
    }

    func save(context: ModelContext) {}

    var canSave: Bool {
        guard !occurence.task.title.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return false
        }
        guard occurence.task.dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
