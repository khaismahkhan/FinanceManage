//
//  TheProjectApp.swift
//  TheProject
//
//

import SwiftUI

@main
struct MyApp: App {
    @StateObject private var transactionHistory = TransactionHistory() // Create instance
    @StateObject private var profileViewModel = ProfileViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(transactionHistory) 
                .environmentObject(profileViewModel) // Inject environment object
// Inject into the environment
        }
    }
}
