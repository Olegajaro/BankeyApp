//
//  Date + Utils.swift
//  BankeyApp
//
//  Created by Олег Федоров on 19.01.2022.
//

import Foundation

extension Date {
    
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
