//
//  CalendarViewModel.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 05.11.2024.
//

import Foundation

class CalendarViewModel: ObservableObject {
    @Published var currentDate = Date()
    
    let calendar = Calendar.current
    var daysInMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: currentDate) else { return [] }
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: startDate) }
    }
    
    func nextMonth() {
        currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
    }
    
    func previousMonth() {
        currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
    }
}
