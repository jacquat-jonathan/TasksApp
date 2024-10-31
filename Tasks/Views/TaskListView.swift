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
    @State private var selectedOccurence: Occurence? = nil

    @Query private var groups: [Group]
    @Query private var tasks: [Task]

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.getSections(tasks: tasks)) { section in
                    Section(
                        header: Text(viewModel.formatDate(section.date))
                            .font(.headline)
                    ) {
                        ForEach(section.occurences) { occurence in
                            OccurenceView(occurence: occurence)
                                .swipeActions {
                                    Button("Delete") {
                                        viewModel.showDeleteConfirmation = true
                                        selectedOccurence = occurence
                                    }
                                    .tint(.red)

                                    Button("Update") {
                                        //viewModel.itemToUpdate = item
                                        viewModel.showingEditOccurenceView = true
                                    }.tint(.blue)
                                }
                        }  // For Each
                    } // Section
                }  // List: Sections
            }  // VStack
            .toolbar {
                ToolbarItemGroup(
                    placement: .topBarTrailing,
                    content: {
                        ToolbarView(viewModel: viewModel)
                    })
            }  // Toolbar
            .navigationTitle(groups[0].name)
            .alert("You're deleting a task.", isPresented: $viewModel.showDeleteConfirmation) {
                Button("Delete only this task", role: .destructive) {
                    if selectedOccurence == nil {
                        return
                    } else {
                        viewModel.deleteOccurence(selectedOccurence!, context: context)
                    }
                }
                Button("Delete All") {
                    if selectedOccurence != nil {
                        viewModel.deleteTask(selectedOccurence!.task, context: context)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Do you want to delete all occurrences of this event, or only the selected occurrence")
            }  // Alert
        }  // NavigationView
        .sheet(isPresented: $viewModel.showingCreateOccurenceView) {
            CreateTaskView(
                isViewPresented: $viewModel.showingCreateOccurenceView)
        }  // Create view
        .sheet(isPresented: $viewModel.showingEditOccurenceView) {
            UpdateTaskView(isViewPresented: $viewModel.showingEditOccurenceView)
        }
        .task({
            if groups.count == 0 {
                context.insert(Group(name: "Default", tasks: []))
                try? context.save()
            }
            viewModel.setData(context: context)
        })
    }
}

#Preview {
    TaskListView()
        .modelContainer(for: Task.self)
}
