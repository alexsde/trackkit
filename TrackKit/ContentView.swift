//
//  ContentView.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

import SwiftUI
import CoreData
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            OverviewView()
                .tabItem {
                    Label("Overview", systemImage: "chart.pie")
                }

            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "folder")
                }

            NavigationStack {
                TransactionsView()
            }
            .tabItem {
                Label("Transactions", systemImage: "list.bullet")
            }
        }
    }
}

#Preview {
    return ContentView()
        .modelContainer(PreviewHelper.container)
}
