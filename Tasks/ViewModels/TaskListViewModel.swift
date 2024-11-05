//
//  File.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import Foundation
import SwiftData

class TaskListViewModel: ObservableObject {
    @Published var showingCreateOccurrenceView = false
    @Published var showingEditOccurrenceView = false
    @Published var showingEditOccurrenceAlert = false
    @Published var showingDeleteConfirmation = false
    @Published var showingMoreOptions = false

    func setData(context: ModelContext) {
        let group = Group(name: "Appartement", tasks: [])

        let task1 = Task(dueDate: .now, repetitionType: 1, repetitionCount: 1, occurrences: [], group: group)
        let t1o1 = Occurrence(title: "Manger un poisson", dueDate: task1.dueDate, priority: 2, hasReminder: false, task: task1)
        let t1o2 = Occurrence(
            title: "Manger un poisson", dueDate: Calendar.current.date(byAdding: .day, value: 1, to: task1.dueDate)!, priority: 2, hasReminder: false,
            task: task1)
        task1.setOccurrences([t1o1, t1o2])
        context.insert(t1o1)
        context.insert(t1o2)
        context.insert(task1)

        let task2 = Task(dueDate: .now, repetitionType: 0, repetitionCount: 0, occurrences: [], group: group)
        let t2o1 = Occurrence(title: "Faire le ménage", dueDate: task2.dueDate, priority: 3, hasReminder: false, task: task2)
        task2.setOccurrences([t2o1])
        context.insert(t2o1)
        context.insert(task2)

        group.tasks = [task1, task2]
        context.insert(group)
    }

    func getSections(tasks: [Task]) -> [ListSection] {
        var sections: [ListSection] = []
        var allOccurrences: [Occurrence] = []
        for task in tasks {
            for occurrence in task.occurrences {
                allOccurrences.append(occurrence)
            }
        }
        let dict = Dictionary(grouping: allOccurrences) { occurrence in
            Calendar.current.startOfDay(for: occurrence.dueDate)
        }
        dict.sorted(by: { $0.key < $1.key }).forEach({
            sections.append(
                ListSection(
                    date: $0.key,
                    occurrences: $0.value.sorted {
                        if $0.isDone != $1.isDone {
                            return !$0.isDone && $1.isDone
                        } else {
                            return $0.priority > $1.priority
                        }
                    }))
        })

        return sections
    }

    func deleteTask(_ task: Task, context: ModelContext) {
        for occurrence in task.occurrences {
            context.delete(occurrence)
        }
        context.delete(task)
        saveContext(context)
    }

    func deleteOccurrence(_ occurrence: Occurrence, context: ModelContext) {
        let task = occurrence.task
        if task.occurrences.count > 1 {
            task.occurrences.remove(at: task.occurrences.firstIndex(where: { $0.id == occurrence.id })!)
            task.dueDate = task.occurrences.first!.dueDate
            context.delete(occurrence)
        } else {
            context.delete(occurrence)
            context.delete(task)
        }
        saveContext(context)
    }

    func formatDate(_ date: Date) -> String {
        return date.formatted(.dateTime.year().month(.wide).day(.twoDigits))
    }

    func deleteAll(tasks: [Task], context: ModelContext) {
        for task in tasks {
            for occurrence in task.occurrences {
                context.delete(occurrence)
            }
            context.delete(task)
        }
        saveContext(context)
    }
    
    func deleteAllDone(tasks: [Task], context: ModelContext) {
        for task in tasks {
            var occurrences: [Occurrence] = []
            for occurrence in task.occurrences {
                if occurrence.isDone {
                    context.delete(occurrence)
                } else {
                    occurrences.append(occurrence)
                }
            }
            if occurrences.count > 0 {
                task.occurrences = occurrences
            } else {
                context.delete(task)
            }
        }
        saveContext(context)
    }
    
    private func saveContext(_ context: ModelContext) {
        try? context.save()
    }
}
