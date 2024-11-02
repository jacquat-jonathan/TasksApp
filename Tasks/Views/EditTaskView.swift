//
//  EditTaskView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import SwiftUI

struct EditTaskView: View {
    @StateObject var viewModel: CRUDInterface
    @Environment(\.modelContext) private var context

    @Binding var isViewPresented: Bool
    let header: String

    var body: some View {
        VStack {
            Text(header)
                .font(.system(size: 28))
                .bold()
                .padding(.top, 25)
            Form {
                Section("Title") {
                    TextField("Title", text: $viewModel.occurrence.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                }  // Section: Title

                Section("Due date") {
                    DatePicker(
                        "Due Date", selection: $viewModel.occurrence.dueDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                }  // Section: Due date
                if viewModel.updateAll {
                    Section("Recurrence") {
                        Picker(
                            selection: $viewModel.occurrence.task.repetitionType,
                            label: Text("Repeat")
                        ) {
                            ForEach(RepetitionTypeEnum.allCases) { rep in
                                Text(rep.name).tag(rep.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        HStack {
                            Picker(
                                selection: $viewModel.occurrence.task.repetitionCount,
                                label: Text("For")
                            ) {
                                ForEach((0...100), id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.automatic)
                            Text("times")
                                .fontWeight(.thin)
                        }
                    }  // Section: Recurrence
                }

                Section("Task priority") {
                    Picker(
                        selection: $viewModel.occurrence.priority,
                        label: Text("Priority")
                    ) {
                        ForEach(PriorityEnum.allCases, id: \.self) { priority in
                            Text(priority.name).tag(priority.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }  // Section: Task Priority

                Button(action: {
                    if viewModel.canSave {
                        viewModel.save(context: context)
                        isViewPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
                // Save button
            }  // Form
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(
                        "Please fill in all fields and select due date that is today or newer."
                    ))
            }
        }  // VStack
    }
}

#Preview {
    EditTaskView(viewModel: CreateTaskViewModel(), isViewPresented: Binding(get: { return true }, set: { _ in }), header: "New item")
}
