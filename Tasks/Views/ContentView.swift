//
//  ContentView.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView {
            TabView {
                TaskListView()
                    .modelContainer(for: Task.self)
                    .tabItem {
                        Label("Tasks", systemImage: "pencil.and.list.clipboard")
                    }
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                Text("Stats")
                    .tabItem {
                        Label("Stats", systemImage: "macbook.gen2")
                    }
                Text("Settings")
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self)
}
