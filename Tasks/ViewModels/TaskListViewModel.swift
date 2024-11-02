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
    
    func setData(context: ModelContext) {
        let group = Group(name: "Appartement", tasks: [])
        
        let task1 = Task(title: "Manger un poisson", priority: 2, dueDate: .now, hasReminder: false, repetitionType: 0, repetitionCount: 0, occurrences: [], group: group)
        let t1o1 = Occurrence(dueDate: task1.dueDate, task: task1)
        let t1o2 = Occurrence(dueDate: Calendar.current.date(byAdding: .day, value: 1, to: task1.dueDate)!, task: task1)
        task1.setOccurrences([t1o1, t1o2])
        context.insert(t1o1)
        context.insert(t1o2)
        context.insert(task1)
        
        let task2 = Task(title: "Faire le ménage", priority: 4, dueDate: .now, hasReminder: false, repetitionType: 0, repetitionCount: 0, occurrences: [], group: group)
        let t2o1 = Occurrence(dueDate: task2.dueDate, task: task2)
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
        dict.sorted(by: {$0.key < $1.key}).forEach({sections.append(ListSection(date: $0.key, occurrences: $0.value.sorted(by: {!$0.isDone && $1.isDone})))})
        
        return sections
    }
    
    private func sortOccurrences(_ occurrences: [Occurrence]) -> [Occurrence] {
        return []
    }
    
    private func printSections(_ sections: [ListSection]) {
        for section in sections {
            print("section: \(section.date)")
        }
    }
    private func printSorted(_ items: [Occurrence]) {
        for item in items {
            print("\(item.dueDate): \(item.task.title)")
        }
    }
    
    
    func deleteTask(_ task: Task, context: ModelContext) {
        for occurrence in task.occurrences {
            context.delete(occurrence)
        }
        context.delete(task)
        try? context.save()
    }
    
    func deleteOccurrence(_ occurrence: Occurrence, context: ModelContext) {
        let task = occurrence.task
        if task.occurrences.count > 1 {
            task.occurrences.remove(at: task.occurrences.firstIndex(where: {$0.id == occurrence.id})!)
            task.dueDate = task.occurrences.first!.dueDate
            context.delete(occurrence)
        } else {
            context.delete(occurrence)
            context.delete(task)
        }
        try? context.save()
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
        try? context.save()
    }
}
