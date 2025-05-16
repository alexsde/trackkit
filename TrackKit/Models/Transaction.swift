//
//  Transaction.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

import Foundation
import SwiftData

@Model
class Transaction {
    var id: UUID
    var timestamp: Date
    var type: String // "income", "expense", "transfer"
    var amount: Decimal
    var note: String?

    var account: Account
    var relatedAccount: Account?

    var category: Category?
    var subcategory: Category?

    var currency: Currency?

    @Relationship(deleteRule: .nullify)
    var pairTransaction: Transaction?

    init(id: UUID = UUID(), timestamp: Date, type: String, amount: Decimal,
         note: String? = nil, account: Account, relatedAccount: Account? = nil,
         category: Category? = nil, subcategory: Category? = nil, currency: Currency? = nil,
         pairTransaction: Transaction? = nil) {
        self.id = id
        self.timestamp = timestamp
        self.type = type
        self.amount = amount
        self.note = note
        self.account = account
        self.relatedAccount = relatedAccount
        self.category = category
        self.subcategory = subcategory
        self.currency = currency
        self.pairTransaction = pairTransaction
    }
}
