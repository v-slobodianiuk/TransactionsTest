//
//  CellView.swift
//  TransactionsTest
//
//  Created by Vadym on 08.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import SwiftUI

struct TransactionCellView: View {
    let iconName: String
    let title: String
    let amount: String
    let type: TransactionType
    
    @State private var isCashBack = false
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(height: 80.0)
                .foregroundColor(isCashBack ? Color(UIColor(red: 0.94, green: 0.98, blue: 0.90, alpha: 1.00)): .white)
                .cornerRadius(10)
            HStack {
                Image(isCashBack ? "cashback" : iconName)
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                    .background(Rectangle()
                        .fill(isCashBack ? .clear : Color(UIColor(red: 0.92, green: 0.94, blue: 0.96, alpha: 1.00)))
                        .cornerRadius(22)
                        .frame(width: 52, height: 52))
                    .padding(.horizontal, 8.0)
                Text(title)
                    .fontWeight(.regular)
                    .padding(.leading)
                Spacer()
                Text(isCashBack ? "+\(amount)" : amount)
            }.foregroundColor(isCashBack ? Color( UIColor(red: 0.44, green: 0.60, blue: 0.31, alpha: 1.00)): .black)
                .padding(.horizontal)
        }
        .onAppear {
            if self.type == .cashback {
                self.isCashBack = true
            } else {
                self.isCashBack = false
            }
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCellView(iconName: "cashback", title: "BurgerKing", amount: "20 GBP", type: .cashback)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Transaction Cell View")
    }
}
