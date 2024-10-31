//
//  File.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import Foundation
import SwiftData

class TaskListViewModel: ObservableObject {
    @Published var showingCreateOccurenceView = false
    @Published var showingEditOccurenceView = false
    @Published var showDeleteConfirmation = false
    
    func setData(context: ModelContext) {
        let group = Group(name: "Appartement", tasks: [])
        
        let task1 = Task(title: "Manger un poisson", priority: 2, dueDate: .now, hasReminder: false, repetitionType: 0, repetitionCount: 0, occurences: [], group: group)
        let t1o1 = Occurence(dueDate: task1.dueDate, task: task1)
        let t1o2 = Occurence(dueDate: Calendar.current.date(byAdding: .day, value: 1, to: task1.dueDate)!, task: task1)
        task1.setOccurences([t1o1, t1o2])
        context.insert(t1o1)
        context.insert(t1o2)
        context.insert(task1)
        
        let task2 = Task(title: "Faire le ménage", priority: 4, dueDate: .now, hasReminder: false, repetitionType: 0, repetitionCount: 0, occurences: [], group: group)
        let t2o1 = Occurence(dueDate: task2.dueDate, task: task2)
        task2.setOccurences([t2o1])
        context.insert(t2o1)
        context.insert(task2)
        
        group.tasks = [task1, task2]
        context.insert(group)
    }
    
    func getSections(tasks: [Task]) -> [ListSection] {
        var sections: [ListSection] = []
        var allOccurences: [Occurence] = []
        for task in tasks {
            for occurence in task.occurences {
                allOccurences.append(occurence)
            }
        }
        allOccurences.sort(by: {$0.dueDate < $1.dueDate})
        let dict = Dictionary(grouping: allOccurences) { occurence in
            Calendar.current.startOfDay(for: occurence.dueDate)
        }
        dict.forEach({sections.append(ListSection(date: $0.key, occurences: $0.value))})
        return sections
    }
    
    
    func deleteTask(_ task: Task, context: ModelContext) {
        for occurence in task.occurences {
            context.delete(occurence)
        }
        context.delete(task)
        try? context.save()
    }
    
    func deleteOccurence(_ occurence: Occurence, context: ModelContext) {
        let task = occurence.task
        if task.occurences.count > 1 {
            task.occurences.remove(at: task.occurences.firstIndex(where: {$0.id == occurence.id})!)
            context.delete(occurence)
        } else {
            context.delete(occurence)
            context.delete(task)
        }
        try? context.save()
    }
    
    func formatDate(_ date: Date) -> String {
        return date.formatted(.dateTime.year().month(.wide).day(.twoDigits))
    }
    
    private func printElements(_ elements: [Occurence]) {
        for element in elements {
            print("\(element.task.title)")
        }
    }
}
