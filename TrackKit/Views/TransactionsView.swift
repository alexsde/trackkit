//
//  TransactionsView.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

import SwiftUI
import SwiftData

struct TransactionsView: View {
    @Environment(\.modelContext) private var modelContext

    // Fetch transactions, newest first
    @Query(sort: \Transaction.timestamp, order: .reverse)
    private var transactions: [Transaction]

    @State private var showAddTransaction = false

    var body: some View {
        NavigationStack {
            ZStack {
                List(transactions) { transaction in
                    VStack(alignment: .leading) {
                        Text(transaction.note ?? "No note")
                            .font(.headline)
                        Text(transaction.timestamp, style: .date)
                            .font(.caption)
                        Text("\(transaction.amount.description) \(transaction.currency?.code ?? "")")
                            .foregroundColor(transaction.amount < 0 ? .red : .green)
                    }
                }

                // Floating Add Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showAddTransaction = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                        .accessibilityLabel("Add Transaction")
                    }
                }
            }
            .navigationTitle("Transactions")
            .sheet(isPresented: $showAddTransaction) {
                AddTransactionView()
            }
        }
    }
}

#Preview {
    return TransactionsView()
        .modelContainer(PreviewHelper.container)
}
