//
//  TransactionModel.swift
//  TheProject
//
//

import Foundation
import SwiftUI
struct TransactionDetail:Identifiable{
    let id = UUID() 
     var transaction:Transaction = .credit
     var amount:Int = 0
     var name:String = ""
     var time:String = ""
}
enum Transaction{
    case credit
    case debit
}
class TransactionHistory: ObservableObject {
    @Published var myHistory: [TransactionDetail] = [
        TransactionDetail(transaction: .credit, amount: 100, name: "Kaismah", time: "02:22 PM"),
        TransactionDetail(transaction: .credit, amount: 100, name: "Kaismah1", time: "02:22 PM"),
        TransactionDetail(transaction: .credit, amount: 100, name: "Kaismah2", time: "02:22 PM"),
        TransactionDetail(transaction: .credit, amount: 100, name: "Kaismah3", time: "02:22 PM"),
        TransactionDetail(transaction: .credit, amount: 100, name: "Kaismah4", time: "02:22 PM"),
        TransactionDetail(transaction: .credit, amount: 100, name: "Kaismah5", time: "02:22 PM")
    ]
}



