//
//  CalendarView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 05.11.2024.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel = CalendarViewModel()
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)

    var body: some View {
        VStack {
            HStack {
                Button(action: { viewModel.previousMonth() }) {
                    Image(systemName: "chevron.left")
                }
                Text(monthYearFormatter.string(from: viewModel.currentDate))
                    .font(.headline)
                Button(action: { viewModel.nextMonth() }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()

            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(dayInitials, id: \.self) { day in
                    Text(day).font(.subheadline).foregroundColor(.gray)
                }

                ForEach(viewModel.daysInMonth, id: \.self) { date in
                    Text("\(dayFormatter.string(from: date))")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical)
                        .background(isToday(date) ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }

    private var dayInitials: [String] {
        ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    }

    private func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }

    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }

    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
}

#Preview {
    CalendarView()
}
