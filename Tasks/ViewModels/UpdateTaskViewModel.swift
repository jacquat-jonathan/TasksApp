//
//  EditTaskViewModel.swift
//  Tasks
//
//  Created by Jonathan Jacquat on 31.10.2024.
//

import Foundation
import SwiftData

class UpdateTaskViewModel: CRUDInterface {
    override func save(context: ModelContext) {// Update logic
        print("update")
        print("saved")
    }
}

