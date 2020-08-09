//
//  TransactionsViewModel.swift
//  TransactionsTest
//
//  Created by Vadym on 08.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import Foundation

protocol TransactionsViewModelProtocol: ObservableObject {
    var transactions: [DailyTransactions] {get set}
    
    func loadData()
}

final class TransactionsViewModel: TransactionsViewModelProtocol {
    
    @Published var transactions = [DailyTransactions]()
    
    //MARK: Fetch data using Apollo
    func loadData() {
        Network.shared.apollo.fetch(query: TransactionsQuery()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print("Failure! Error: \(error.localizedDescription)")
            case .success(let graphQLResult):
                guard let data = graphQLResult.data?.dailyTransactionsFeed else { return }
                self.getData(from: data)
            }
        }
    }
    
    //MARK: Sorting transactions by day
    private func getData(from data: [TransactionsQuery.Data.DailyTransactionsFeed?]) {
        for item in data {
            guard let item = item else { return }
            if item.__typename == "DaySectionWidget" {
                if let date = item.asDaySectionWidget?.date,
                    let total = item.asDaySectionWidget?.amount {
                    let convertedDate = self.convertDateString(dateString: date, fromFormat: "YYYY-MM-dd", toFormat: "MMMM, d")
                    self.transactions.append(DailyTransactions(day: convertedDate, total: "\(total.value) \(total.currencyCode.rawValue)"))
                }
            }
            if item.__typename == "TransactionWidget" {
                if let id = item.asTransactionWidget?.transaction.id,
                    let iconName = item.asTransactionWidget?.image?.iconName,
                    let title = item.asTransactionWidget?.transaction.title,
                    let amount = item.asTransactionWidget?.transaction.amount,
                    let type = item.asTransactionWidget?.transaction.type {
                    self.transactions[self.transactions.count - 1].transactions.append(Transaction(id: Int(id) ?? 0, iconName: iconName, title: title, amount: "\(amount.value) \(amount.currencyCode.rawValue)", type: type))
                }
            }
        }
    }
    
    //MARK: Date formatter converter
    private func convertDateString(dateString : String!, fromFormat sourceFormat : String!, toFormat desFormat : String!) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = desFormat
        return dateFormatter.string(from: date!)
    }
}
