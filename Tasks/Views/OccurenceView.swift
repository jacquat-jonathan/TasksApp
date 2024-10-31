//
//  OccurenceView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import SwiftUI
import SwiftData

struct OccurenceView: View {
    @Environment(\.modelContext) private var context
    
    let occurence: Occurence
    
    func getColor() -> Color {
        switch PriorityEnum.from(occurence.task.priority) {
        case .low:
            return Color.blue
        case .medium:
            return Color.green
        case .high:
            return Color.yellow
        case .urgent:
            return Color.red
        }
    }

    var body: some View {
        HStack {
            Image(systemName: "tag.fill")
                .foregroundStyle(getColor())
                .padding(.trailing)
            Text(occurence.task.title)
                .font(.body)

            Spacer()

            Button {
                occurence.setDone(!occurence.isDone)
                //try? context.save()
            } label: {
                Image(
                    systemName: occurence.isDone ? "checkmark.circle.fill" : "circle"
                )
                .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    OccurenceView(occurence: Occurence(dueDate: .now, task: Task()))
        .modelContainer(for: Occurence.self)
}
