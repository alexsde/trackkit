//
//  Account.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

import Foundation
import SwiftData

@Model
class Account {
    var id: UUID
    var name: String
    var currency: Currency

    init(id: UUID = UUID(), name: String, currency: Currency) {
        self.id = id
        self.name = name
        self.currency = currency
    }
}
