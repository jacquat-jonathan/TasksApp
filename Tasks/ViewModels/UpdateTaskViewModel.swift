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
        let task = occurrence.task
        let reps = task.repetitionCount + 1
        if task.occurrences.count > reps {
            task.occurrences.removeLast(task.occurrences.count - reps)
        } else if task.occurrences.count < reps {
            for _ in task.occurrences.count...task.repetitionCount {
                task.occurrences.append(Occurrence(dueDate: .now, task: task))
            }
        }
        
        for (rep, occurrence) in task.occurrences.enumerated() {
            let newDate = getNextDate(by: RepetitionTypeEnum.from(task.repetitionType), to: task.dueDate, value: rep)
            occurrence.setDueDate(newDate)
        }
        
        try? context.save()
    }
}

