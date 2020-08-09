//
//  ContentView.swift
//  TransactionsTest
//
//  Created by Vadym on 07.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import SwiftUI

struct TransactionsContentView<TransactionsViewModel>: View  where TransactionsViewModel: TransactionsViewModelProtocol {
    
    @ObservedObject private var viewModel: TransactionsViewModel
    @State private var isCashback = false
    
    init(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
        self.viewModel.loadData()
    }
    
    var body: some View {
        
        List() {
            ForEach(viewModel.transactions, id: \.day) { dailyTransaction in
                Section(footer: TransactionSectionFooter()) {
                    TransactionSectionHeader(date: dailyTransaction.day, amount: dailyTransaction.total)
                        .padding(.horizontal)
                    ForEach(dailyTransaction.transactions, id: \.title) { transaction in
                        TransactionCellView(iconName: transaction.iconName, title: transaction.title, amount: transaction.amount, type: transaction.type)
                            .padding([.top, .leading, .trailing])
                    }
                }
            }
            .listRowInsets(EdgeInsets())
        }
        .onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsContentView(viewModel: TransactionsViewModel())
    }
}
