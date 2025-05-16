//
//  Currency.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

import Foundation
import SwiftData

@Model
class Currency {
    var id: UUID
    var code: String
    var name: String
    var symbol: String

    init(id: UUID = UUID(), code: String, name: String, symbol: String) {
        self.id = id
        self.code = code
        self.name = name
        self.symbol = symbol
    }
}
