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
                let occ = Occurrence(dueDate: newDate, task: task)
                context.insert(occ)
                occurrences.append(occ)
            }
        }
        task.occurrences = occurrences
        context.insert(task)
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
