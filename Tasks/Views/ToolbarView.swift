//
//  ToolbarView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import SwiftUI
import SwiftData

struct ToolbarView: View {
    @StateObject var viewModel: TaskListViewModel
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Button {
            viewModel.showingCreateOccurrenceView = true
        } label: {
            Image(systemName: "plus.circle")
        }
        
        Menu {
            Button(role: .destructive) {
                viewModel.deleteAll(tasks: tasks, context: context)
            } label: {
                Label("Delete All", systemImage: "trash")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

#Preview {
    ToolbarView(viewModel: TaskListViewModel())
}
