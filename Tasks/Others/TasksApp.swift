//
//  TasksApp.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import SwiftUI
import SwiftData

@main
struct TasksApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
            Occurence.self,
            Group.self,
            Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
