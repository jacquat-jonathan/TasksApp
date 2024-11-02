//
//  OccurrenceView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import SwiftUI
import SwiftData

struct OccurrenceView: View {
    @Environment(\.modelContext) private var context
    
    let occurrence: Occurrence
    
    func getColor() -> Color {
        switch PriorityEnum.from(occurrence.priority) {
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
            Text(occurrence.title)
                .font(.body)

            Spacer()

            Button {
                occurrence.setDone(!occurrence.isDone)
            } label: {
                Image(
                    systemName: occurrence.isDone ? "checkmark.circle.fill" : "circle"
                )
                .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    OccurrenceView(occurrence: Occurrence(title: "Test title", dueDate: .now, priority: PriorityEnum.low.rawValue, hasReminder: false, task: Task()))
        .modelContainer(for: Occurrence.self)
}
