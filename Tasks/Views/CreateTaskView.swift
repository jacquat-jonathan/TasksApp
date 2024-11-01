//
//  CreateTaskView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import SwiftUI

struct CreateTaskView: View {
    @StateObject var viewModel: CreateTaskViewModel = CreateTaskViewModel()
    @Binding var isViewPresented: Bool
    var body: some View {
        NavigationView {
            EditTaskView(viewModel: viewModel, isViewPresented: $isViewPresented, header: "New task")
        }
    }
}

#Preview {
    CreateTaskView(isViewPresented: Binding(get: {return true}, set: {_ in}))
        .modelContainer(for: Occurrence.self)
}
