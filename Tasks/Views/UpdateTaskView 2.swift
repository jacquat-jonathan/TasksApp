//
//  CreateTaskView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import SwiftUI

struct UpdateTaskView: View {
    @StateObject var viewModel: UpdateTaskViewModel
    @Binding var isViewPresented: Bool
    
    init(occurrence: Occurrence, updateAll: Bool, isViewPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: UpdateTaskViewModel(occurrence: occurrence, updateAll: updateAll))
        self._isViewPresented = isViewPresented
    }
    
    var body: some View {
        NavigationView {
            EditTaskView(viewModel: viewModel, isViewPresented: $isViewPresented, header: "Update task")
        }
    }
}

#Preview {
    UpdateTaskView(occurrence: Occurrence(), updateAll: true, isViewPresented: Binding(get: {return true}, set: {_ in}))
        .modelContainer(for: Occurrence.self)
}
