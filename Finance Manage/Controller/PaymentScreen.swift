//
//  PaymentScreen.swift
//  TheProject
//
//

import SwiftUI

struct PaymentsView: View {
    @EnvironmentObject var transactionHistory: TransactionHistory

    var body: some View {
        NavigationStack {
            VStack {
                Text("Transaction History")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .accessibilityLabel("Transaction History")
                    .accessibilityHint("List of all your transactions.")
                
                // List of transactions
                List(transactionHistory.myHistory) { transaction in
                    TransactionRow(transaction: transaction)
                        .listRowSeparator(.hidden) // Hide list separators
                        .padding(.vertical, 5)
                        .accessibilityElement(children: .contain)
                }
                .listStyle(PlainListStyle())
                .accessibilityLabel("Transaction List")
                .accessibilityHint("Displays all recorded transactions.")
            }
        }
    }
}

struct TransactionRow: View {
    let transaction: TransactionDetail
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(transaction.name)
                    .font(.headline)
                    .accessibilityLabel("Transaction with \(transaction.name)")
                
                Text(transaction.time)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .accessibilityLabel("Time: \(transaction.time)")
            }
            Spacer()
            
            Text("$. \(transaction.amount)")
                .font(.headline)
                .foregroundColor(transaction.transaction == .credit ? .green : .red)
                .accessibilityLabel(transaction.transaction == .credit
                                    ? "Credit of \(transaction.amount) dollars"
                                    : "Debit of \(transaction.amount) dollars")
                .accessibilityHint("This is a \(transaction.transaction == .credit ? "credit" : "debit") transaction.")
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .accessibilityElement(children: .combine) 
    }
}
