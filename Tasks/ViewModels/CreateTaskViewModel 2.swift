//
//  EditTaskViewModel.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import Foundation
import SwiftData

class CreateTaskViewModel: CRUDInterface {
    override func save(context: ModelContext) {
        let task = occurrence.task
        context.insert(occurrence)
        var occurrences: [Occurrence] = [occurrence]
        if task.repetitionType != RepetitionTypeEnum.no.rawValue {
            for rep in 1...task.repetitionCount {
                let newDate = getNextDate(by: RepetitionTypeEnum.from(task.repetitionType), to: task.dueDate, value: rep)
                let occ = Occurrence(title: occurrence.title, dueDate: newDate, priority: occurrence.priority, hasReminder: occurrence.hasReminder, task: task)
                context.insert(occ)
                occurrences.append(occ)
            }
        }
        task.occurrences = occurrences
        context.insert(task)
        try? context.save()
    }
}
