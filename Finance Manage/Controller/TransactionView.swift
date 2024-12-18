//
//  TransactionView.swift
//  TheProject
//
//

import SwiftUI

struct TransactionView: View {
    var transaction: Transaction
    var transactionTitle: String
    @EnvironmentObject var transactionHistory1: TransactionHistory // Shared environment object

    @State private var inputAmount: String = ""
    @State private var inputName: String = ""
    @State private var inputIban: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                // Name Input Field
                VStack(alignment: .leading, spacing: 10) {
                    Text("Enter Name")
                        .font(.system(size: 18))
                        .bold()
                        .padding([.leading, .trailing, .top], 10)
                        .accessibilityLabel("Enter Name")
                        .accessibilityHint("Enter the recipient's name")
                    
                    HStack {
                        TextField("Enter User name", text: $inputName)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .keyboardType(.default)
                            .accessibilityLabel("Name Input Field")
                            .accessibilityHint("Type the name of the recipient")
                    }
                    .padding(.all, 10)
                }
                .frame(height: 120)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)

                // IBAN Input Field
                VStack(alignment: .leading, spacing: 10) {
                    Text("Enter Iban No")
                        .font(.system(size: 18))
                        .bold()
                        .padding([.leading, .trailing, .top], 10)
                        .accessibilityLabel("Enter IBAN Number")
                        .accessibilityHint("Enter the IBAN number for the transaction")
                    
                    HStack {
                        TextField("Enter Iban No", text: $inputIban)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .keyboardType(.default)
                            .accessibilityLabel("IBAN Input Field")
                            .accessibilityHint("Type the IBAN number")
                    }
                    .padding(.all, 10)
                }
                .frame(height: 120)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Enter Amount")
                        .font(.system(size: 18))
                        .bold()
                        .padding([.leading, .trailing, .top], 10)
                        .accessibilityLabel("Enter Amount")
                        .accessibilityHint("Enter the transaction amount")
                    
                    HStack {
                        TextField("Enter amount", text: $inputAmount)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .keyboardType(.numberPad)
                            .accessibilityLabel("Amount Input Field")
                            .accessibilityHint("Type the amount to transfer")
                    }
                    .padding(.all, 10)
                }
                .frame(height: 120)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()

                Button {
                    if inputIban.isEmpty || inputName.isEmpty || inputAmount.isEmpty {
                        alertMessage = "All fields are required!"
                        showAlert = true
                    } else if let amount = Int(inputAmount), amount > 0 {
                        transactionHistory1.myHistory.append(
                            TransactionDetail(
                                transaction: self.transaction,
                                amount: amount,
                                name: inputName,
                                time: getCurrentTime()
                            )
                        )
                        clearFields()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        alertMessage = "Please enter a valid amount."
                        showAlert = true
                    }
                } label: {
                    PrimaryButtonView(title: transactionTitle)
                        .accessibilityLabel(transactionTitle)
                        .accessibilityHint("Tap to confirm the transaction")
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Input Error"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationTitle("Transaction")
        .accessibilityLabel("Transaction Screen")
        .accessibilityHint("Enter transaction details and confirm the transaction")
    }

    private func clearFields() {
        inputIban = ""
        inputName = ""
        inputAmount = ""
    }

    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        return formatter.string(from: Date())
    }
}

#Preview {
    TransactionView(transaction: .credit, transactionTitle: "Load Money")
        .environmentObject(TransactionHistory())
}
