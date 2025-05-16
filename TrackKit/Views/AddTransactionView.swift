//
//  AddTransactionView.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

import SwiftUI
import SwiftData

struct AddTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Query private var accounts: [Account]
    @Query private var categories: [Category]
    @Query private var currencies: [Currency]

    @State private var transactionType: TransactionType = .expense

    @State private var selectedAccount: Account?
    @State private var relatedAccount: Account?

    @State private var selectedCategory: Category?
    @State private var selectedSubcategory: Category?

    @State private var amount: Decimal = 0
    @State private var note: String = ""
    @State private var date: Date = .now

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Picker for transaction type
                    Picker("Type", selection: $transactionType) {
                        ForEach(TransactionType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    
                    Picker("Account", selection: $selectedAccount) {
                        ForEach(accounts) { account in
                            Text(account.name).tag(account as Account?)
                        }
                    }

                    if transactionType == .transfer {
                        Picker("To Account", selection: $relatedAccount) {
                            ForEach(accounts) { account in
                                Text(account.name).tag(account as Account?)
                            }
                        }
                    }
                    
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)

                    // Categories for income/expense
                    if transactionType != .transfer {
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(categories.filter { $0.parent == nil }) { category in
                                Text(category.name).tag(category as Category?)
                            }
                        }

                        if let parent = selectedCategory {
                            Picker("Subcategory", selection: $selectedSubcategory) {
                                ForEach(categories.filter { $0.parent == parent }) { sub in
                                    Text(sub.name).tag(sub as Category?)
                                }
                            }
                        }
                    }

                    TextField("Note", text: $note)
                }
                
                Section {
                    VStack(spacing: 0) {
                        Button {
                            saveTransaction()
                            dismiss()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Save")
                                    .foregroundStyle(.tint)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding()
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .background(Color(.systemBackground))

                        Divider()

                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Cancel")
                                    .foregroundStyle(.tint)
                                Spacer()
                            }
                            .padding()
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .background(Color(.systemBackground))
                    }
                }

            }
            
            .formStyle(.grouped)

            .navigationTitle("Add Transaction")
        }
    }

    private func saveTransaction() {
        guard let account = selectedAccount else { return }

        let transaction = Transaction(
            timestamp: date,
            type: transactionType.rawValue.lowercased(),
            amount: transactionType == .expense ? -amount : amount,
            note: note.isEmpty ? nil : note,
            account: account,
            relatedAccount: transactionType == .transfer ? relatedAccount : nil,
            category: transactionType == .transfer ? nil : selectedCategory,
            subcategory: transactionType == .transfer ? nil : selectedSubcategory,
            currency: account.currency
        )

        modelContext.insert(transaction)

        if transactionType == .transfer,
           let toAccount = relatedAccount {
            let pairedTransaction = Transaction(
                timestamp: date,
                type: transactionType.rawValue,
                amount: amount,
                note: note.isEmpty ? nil : note,
                account: toAccount,
                relatedAccount: account,
                currency: toAccount.currency,
                pairTransaction: transaction
            )

            modelContext.insert(pairedTransaction)
        }
    }
}

#Preview {
    return AddTransactionView()
        .modelContainer(PreviewHelper.container)
}
