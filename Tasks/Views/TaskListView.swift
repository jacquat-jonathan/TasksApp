//
//  TaskListView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import SwiftData
import SwiftUI

struct TaskListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = TaskListViewModel()
    @State private var selectedOccurrence: Occurrence? = nil

    @Query private var groups: [Group]
    @Query private var tasks: [Task]

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.getSections(tasks: tasks)) { section in
                    Section(header: Text(viewModel.formatDate(section.date)).font(.headline)) {
                        ForEach(section.occurrences) { occurrence in
                            OccurrenceView(occurrence: occurrence)
                                .swipeActions {
                                    Button("Delete") {
                                        if occurrence.task.occurrences.count > 1 {
                                            selectedOccurrence = occurrence
                                            viewModel.showDeleteConfirmation = true
                                        } else {
                                            viewModel.deleteOccurrence(occurrence, context: context)
                                        }
                                    }
                                    .tint(.red)

                                    Button("Update") {
                                        selectedOccurrence = occurrence
                                        viewModel.showingEditOccurrenceView = true
                                    }
                                    .tint(.blue)
                                }
                        }  // For Each
                    }  // Section
                }  // List: Sections
            }  // VStack
            .toolbar {
                ToolbarItemGroup(
                    placement: .topBarTrailing,
                    content: {
                        ToolbarView(viewModel: viewModel)
                    })
            }  // Toolbar
            .navigationTitle("Tasks")
            .alert("You're deleting a task.", isPresented: $viewModel.showDeleteConfirmation) {
                Button("Delete only this task", role: .destructive) {
                    if selectedOccurrence == nil {
                        return
                    } else {
                        viewModel.deleteOccurrence(selectedOccurrence!, context: context)
                    }
                }
                Button("Delete All") {
                    if selectedOccurrence != nil {
                        viewModel.deleteTask(selectedOccurrence!.task, context: context)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Do you want to delete all occurrences of this event, or only the selected occurrence")
            }  // Alert
        }  // NavigationView
        .sheet(isPresented: $viewModel.showingCreateOccurrenceView) {
            CreateTaskView(isViewPresented: $viewModel.showingCreateOccurrenceView)
        }  // Create view
        .sheet(isPresented: $viewModel.showingEditOccurrenceView) {
            UpdateTaskView(occurrence: selectedOccurrence!, isViewPresented: $viewModel.showingEditOccurrenceView)
        }
        .task({
            if groups.count == 0 {
                context.insert(Group(name: "Default", tasks: []))
                try? context.save()
            }
            //viewModel.setData(context: context)
        })
    }
}

#Preview {
    TaskListView()
        .modelContainer(for: Task.self)
}
