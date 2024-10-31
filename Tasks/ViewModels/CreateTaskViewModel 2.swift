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
        print("save")
        let task = occurence.task
        // insert occurence
        context.insert(occurence)
        // Create an array of occurences
        var occurences: [Occurence] = [occurence]

        // for each rep count, create a copy of occurence + repetitionType
        if task.repetitionType != RepetitionTypeEnum.no.rawValue {
            for rep in 1...task.repetitionCount {
                let newDate = getNextDate(
                    by: RepetitionTypeEnum.from(task.repetitionType), to: task.dueDate,
                    value: rep)
                let occ = Occurence(dueDate: newDate, task: task)
                context.insert(occ)
                occurences.append(occ)
            }
            // Set the task occurences to the newly created occurrences array
            task.occurences = occurences
        }
        // insert task
        context.insert(task)
        // Save the context
        try? context.save()
    }

    private func getNextDate(by: RepetitionTypeEnum, to: Date, value: Int) -> Date {
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
}
