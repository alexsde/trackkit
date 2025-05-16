//
//  Category.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

import Foundation
import SwiftData

@Model
class Category {
    var id: UUID
    var name: String
    var parent: Category?

    init(id: UUID = UUID(), name: String, parent: Category? = nil) {
        self.id = id
        self.name = name
        self.parent = parent
    }
}
