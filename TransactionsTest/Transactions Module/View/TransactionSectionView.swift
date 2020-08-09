//
//  SwiftUIView.swift
//  TransactionsTest
//
//  Created by Vadym on 09.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import SwiftUI

struct TransactionSectionHeader: View {
    
    let date: String
    let amount: String
    
    var body: some View {
        ZStack {
            HStack {
                Text(date)
                    .fontWeight(.thin)
                Spacer()
                Text(amount)
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal)
        .background(Color(.white))
    }
}

struct TransactionSectionFooter: View {
    var body: some View {
        ZStack {
            Color(UIColor(red: 0.96, green: 0.98, blue: 0.99, alpha: 1.00))
        }
        .frame(height: 10.0)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionSectionHeader(date: "August, 9", amount: "-120.50 GPB")
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}
