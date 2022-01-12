//
//  AccontSummaryCellViewModel.swift
//  BankeyApp
//
//  Created by Олег Федоров on 14.01.2022.
//

import Foundation

enum AccuntType: String {
    case banking = "Banking"
    case creditCard = "Credit Card"
    case investment = "Investment"
}

struct AccountSummaryCellViewModel {
    let accountType: AccuntType
    let accountName: String
    let balance: Decimal
    
    var balanceAsAttributedString: NSAttributedString {
        return CurrencyFormatter().makeAttributedCurrency(balance)
    }
}
