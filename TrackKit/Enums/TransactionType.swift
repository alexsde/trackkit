//
//  TransactionType.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

enum TransactionType: String, CaseIterable, Identifiable {
    case expense = "Expense"
    case income = "Income"
    case transfer = "Transfer"

    var id: String { rawValue }
}
