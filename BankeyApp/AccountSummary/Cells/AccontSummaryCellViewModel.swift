//
//  AccontSummaryCellViewModel.swift
//  BankeyApp
//
//  Created by Олег Федоров on 14.01.2022.
//

import Foundation

enum AccountType: String, Codable {
    case banking = "Banking"
    case creditCard = "CreditCard"
    case investment = "Investment"
}

struct AccountSummaryCellViewModel {
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
    
    var balanceAsAttributedString: NSAttributedString {
        return CurrencyFormatter().makeAttributedCurrency(balance)
    }
}
