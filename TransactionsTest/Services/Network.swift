//
//  NetworkService.swift
//  TransactionsTest
//
//  Created by Vadym on 08.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import Foundation
import Apollo

class Network {
    
    static let shared = Network()

    private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:4000/")!)
}
