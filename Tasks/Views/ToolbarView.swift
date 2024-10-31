//
//  ToolbarView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import SwiftUI

struct ToolbarView: View {
    @StateObject var viewModel: TaskListViewModel
    var body: some View {
        Button {
            viewModel.showingCreateOccurenceView = true
        } label: {
            Image(systemName: "plus.circle")
        }
        
        Button {
            print("more options")
        } label: {
            Image(systemName: "ellipsis")
        }
    }
}

#Preview {
    ToolbarView(viewModel: TaskListViewModel())
}
