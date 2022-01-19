//
//  AccountSummaryHeaderViewModel.swift
//  BankeyApp
//
//  Created by Олег Федоров on 19.01.2022.
//

import Foundation

struct AccountSummaryHeaderViewModel {
    
    let welcomeMessage: String
    let name: String
    let date: Date
    
    var dateFormatted: String {
        return date.monthDayYearString
    }
}
