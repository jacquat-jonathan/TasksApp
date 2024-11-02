//
//  EditTaskViewModel.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import Foundation
import SwiftData

class UpdateTaskViewModel: CRUDInterface {
    override func save(context: ModelContext) {
        if updateAll {
            let task = occurrence.task
            task.setDueDate(occurrence.dueDate)
            let reps = task.repetitionCount + 1
            if task.occurrences.count > reps {
                task.occurrences.removeLast(task.occurrences.count - reps)
            } else if task.occurrences.count < reps {
                for _ in task.occurrences.count...task.repetitionCount {
                    task.occurrences.append(Occurrence(title: occurrence.title, dueDate: .now, priority: occurrence.priority, hasReminder: occurrence.hasReminder, task: task))
                }
            }

            for (rep, occ) in task.occurrences.enumerated() {
                let newDate = getNextDate(by: RepetitionTypeEnum.from(task.repetitionType), to: task.dueDate, value: rep)
                occ.setDueDate(newDate)
                occ.setTitle(occurrence.title)
                occ.setPriority(occurrence.priority)
                occ.setHasReminder(occurrence.hasReminder)
            }
        }

        try? context.save()
    }
}
