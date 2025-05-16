//
//  TrackKitApp.swift
//  TrackKit
//
//  Created by Alex on 16/05/2025.
//

import SwiftUI
import SwiftData

@main
struct TrackKitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Transaction.self,
            Account.self,
            Category.self,
            Currency.self
        ])
    }
}
