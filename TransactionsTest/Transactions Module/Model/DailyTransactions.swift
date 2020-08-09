//
//  DailyTransactions.swift
//  TransactionsTest
//
//  Created by Vadym on 09.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import Foundation

struct DailyTransactions {
    let day: String
    let total: String
    var transactions = [Transaction] ()
}

struct Transaction {
    let id: Int
    let iconName: String
    let title: String
    let amount: String
    let type: TransactionType
}
