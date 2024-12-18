//
//  ContentView.swift
//  TheProject
//

import SwiftUI



struct ContentView: View {
    
    @State private var navigateToLoadMoney = false
    @State private var navigateSendMoney = false
    @EnvironmentObject var transactionHistory2: TransactionHistory
    @Binding var selectedTab: Int

    
    var currentBalance: Int {
        transactionHistory2.myHistory.reduce(0) { result, transaction in
            switch transaction.transaction {
            case .credit:
                return result + transaction.amount
            case .debit:
                return result - transaction.amount
            }
        }
    }
    
    var body: some View {
        NavigationStack {
                VStack(spacing: 20) {
                    HStack(alignment: .top, spacing: 10) {
                        VStack(alignment: .leading) {
                            Text("Current balance")
                                .font(.headline)
                                .foregroundColor(.white)
                                .accessibilityLabel("Current Balance")
                                .accessibilityHint("Displays your total balance in the account.")
                            
                            Text("Rs. \(currentBalance)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .accessibilityValue("\(currentBalance) rupees")
                            
                            Spacer()
                                .padding(.bottom,30)
                            HStack {
                                Image(systemName: "arrow.down.circle.fill")
                                    .font(.largeTitle)
                                    .accessibilityHidden(true) 
                                Spacer()
                                Image(systemName: "arrow.right.circle")
                                    .accessibilityHidden(true)
                            }
                        }
                        .padding()
                        .background(Color.teal)
                        .cornerRadius(12)
                        .frame(maxHeight: .infinity)
                        .accessibilityElement(children: .combine)
                        
                        VStack(spacing: 20) {
                            Button(action: {
                                navigateToLoadMoney = true
                            }) {
                                VStack {
                                    HStack{
                                        Image(systemName: "arrow.down.circle.fill")
                                            .font(.largeTitle)
                                            .accessibilityHidden(true)
                                        Spacer()
                                    }
                                    .padding(.bottom,30)
                                    
                                    HStack{
                                        Text("Load Money")
                                            .font(.headline)
                                            .accessibilityLabel("Load Money")
                                            .accessibilityHint("Tap to add money to your account.")
                                        Spacer()
                                    }
                                }
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(12)
                            }
                            .frame(height: 100)
                            .padding(.bottom,30)
                            
                            Button(action: {
                                navigateSendMoney = true
                            }) {
                                VStack {
                                    HStack{
                                        Spacer()
                                        Image(systemName: "arrow.up.right.circle.fill")
                                            .font(.largeTitle)
                                            .accessibilityHidden(true)
                                    }
                                    .padding(.bottom,30)
                                    
                                    Text("Send & Request")
                                        .font(.headline)
                                        .accessibilityLabel("Send and Request")
                                        .accessibilityHint("Tap to send or request money.")
                                }
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .cornerRadius(12)
                            }
                            .frame(height: 100)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                    
                    VStack(alignment: .leading) {
                        Text("⚠️ Several services may be unavailable 12:35 - 1:35 AM PKT on 14th & 15th Dec due to a partner maintenance event")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .accessibilityLabel("Maintenance Notification")
                            .accessibilityHint("Some services will not be available between 12:35 and 1:35 AM.")
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Transactions")
                                .font(.headline)
                                .accessibilityLabel("Recent Transactions")
                            Spacer()
                            Button(action: {
                                selectedTab = 1
                            }) {
                                Text("See all")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                                    .accessibilityLabel("See All Transactions")
                                    .accessibilityHint("Tap to view all transactions.")
                            }
                        }
                        
                        List(transactionHistory2.myHistory.prefix(5)) { transaction in
                            HStack {
                                VStack(alignment: .leading) {
                                    
                                    Text(transaction.name)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .accessibilityLabel("Transaction with \(transaction.name)")
                                        .padding([.leading,.trailing])
                                    Text(transaction.time)
                                        .padding([.leading,.trailing])
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .accessibilityLabel("Time: \(transaction.time)")
                                }
                                Spacer()
                                Text("$. \(transaction.amount)")
                                    .padding(.trailing)
                                    .font(.headline)
                                    .foregroundColor(transaction.transaction == .credit ? .green : .red)
                                    .accessibilityLabel("\(transaction.transaction == .credit ? "Credit" : "Debit") of \(transaction.amount) rupees")
                                    

                            }
                            .padding(.vertical, 5)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)
                        }
                        .listStyle(PlainListStyle())
                    }
                    .padding(.horizontal)
                }
                
                NavigationLink(
                    destination: TransactionView(transaction: .credit, transactionTitle: "Load Money"),
                    isActive: $navigateToLoadMoney
                ) { EmptyView() }

                NavigationLink(
                    destination: TransactionView(transaction: .debit, transactionTitle: "Send And Request"),
                    isActive: $navigateSendMoney
                ) { EmptyView() }
        }
    }
}
