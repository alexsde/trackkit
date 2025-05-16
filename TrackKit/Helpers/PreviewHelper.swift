//
//  PreviewHelper.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

import Foundation
import SwiftData

@MainActor
struct PreviewHelper {
    static var container: ModelContainer {
        let container = try! ModelContainer(
            for: Transaction.self, Account.self, Category.self, Currency.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )

        let context = container.mainContext

        // Sample currency
        let eur = Currency(code: "EUR", name: "Euro", symbol: "€")
        let usd = Currency(code: "USD", name: "US Dollar", symbol: "$")

        // Sample accounts
        let revolut = Account(name: "Revolut EUR", currency: eur)
        let cash = Account(name: "Cash", currency: eur)

        // Sample categories
        let salary = Category(name: "Salary")
        let shopping = Category(name: "Shopping")
        let groceries = Category(name: "Groceries", parent: shopping)

        // Sample transactions
        let t1 = Transaction(
            timestamp: .now,
            type: "expense",
            amount: -22.86,
            note: "Magsafe ring",
            account: revolut,
            category: shopping,
            currency: eur
        )

        let t2 = Transaction(
            timestamp: .now.addingTimeInterval(-3600),
            type: "expense",
            amount: -64.99,
            note: "Groceries",
            account: cash,
            category: groceries,
            subcategory: groceries,
            currency: eur
        )
        
        let t3 = Transaction(
            timestamp: .now.addingTimeInterval(-13000),
            type: "income",
            amount: 2000,
            note: "Salary",
            account: revolut,
            category: salary,
            subcategory: nil,
            currency: eur
        )

        context.insert(eur)
        context.insert(usd)
        context.insert(revolut)
        context.insert(cash)
        context.insert(salary)
        context.insert(shopping)
        context.insert(groceries)
        context.insert(t1)
        context.insert(t2)
        context.insert(t3)

        return container
    }
}

