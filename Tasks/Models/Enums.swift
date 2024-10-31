//
//  Enums.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 30.10.2024.
//

import Foundation

enum PriorityEnum: Int, CaseIterable, Identifiable {
    case low = 1, medium, high, urgent
    
    var id: Int { self.rawValue }
    
    var name: String {
        switch self {
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        case .urgent: return "Urgent"
        }
    }
    
    static func from(_ rawValue: Int) -> PriorityEnum {
        return PriorityEnum(rawValue: rawValue)!
    }
}

enum RepetitionTypeEnum: Int, CaseIterable, Identifiable {
    case no = 0, daily, weekly, monthly, yearly
    
    var id: Int { self.rawValue }
    
    var name: String {
        switch self {
        case .no: return "None"
        case .daily: return "Daily"
        case .weekly: return "Weekly"
        case .monthly: return "Monthly"
        case .yearly: return "Yearly"
        }
    }
    
    static func from(_ rawValue: Int) -> RepetitionTypeEnum {
        return RepetitionTypeEnum(rawValue: rawValue)!
    }
}
