//
//  CreateTaskView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import SwiftUI

struct UpdateTaskView: View {
    @StateObject var viewModel: UpdateTaskViewModel = UpdateTaskViewModel()
    @Binding var isViewPresented: Bool
    var body: some View {
        NavigationView {
            EditTaskView(viewModel: viewModel, isViewPresented: $isViewPresented, header: "Update task")
        }
    }
}

#Preview {
    UpdateTaskView(isViewPresented: Binding(get: {return true}, set: {_ in}))
        .modelContainer(for: Occurence.self)
}
